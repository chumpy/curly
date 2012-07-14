//
//  CurlyDocument.m
//  Curly
//
//  Created by Kevin Beddingfield on 4/12/12.
//  Copyright (c) 2012 Kevin Beddingfield. All rights reserved.
//

#import "CurlyDocument.h"


@implementation CurlyDocument
@synthesize addReqHeaderValueText;
@synthesize useBasicAuth;
@synthesize basicAuthUsername;
@synthesize basicAuthPassword;
@synthesize method;
@synthesize responseTab;
@synthesize requestHeadersView;
@synthesize responseTextView;
@synthesize requestTextView;
@synthesize responseHeadersView;
@synthesize headerTableDatasource;
@synthesize reqHeaderTableDatasource;
@synthesize addReqHeaderKeyText;
@synthesize url;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"CurlyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (void)updateResponseHeaders:(NSHTTPURLResponse *)urlResponse {
    if ([urlResponse respondsToSelector:@selector(allHeaderFields)]) {
		NSMutableDictionary *dictionary = (NSMutableDictionary *)[urlResponse allHeaderFields];
        [headerTableDatasource setHeaderView:responseHeadersView];
        [headerTableDatasource setDictionary:dictionary];
		[responseHeadersView reloadData];
	}
}

- (void)setupRequest:(NSMutableURLRequest **)req_p urlResponse_p:(NSHTTPURLResponse **)urlResponse_p {
    NSURL *urlFromTextField = [NSURL URLWithString:[url stringValue]];
    *req_p = [NSMutableURLRequest requestWithURL:urlFromTextField];
    
    //do not use sessions from safari
    [*req_p setHTTPShouldHandleCookies:NO];
    
    //set request headers
    [*req_p setAllHTTPHeaderFields:[reqHeaderTableDatasource dictionary]];
    
    //get the method verb ahead of time
    NSString *methodString = [method titleOfSelectedItem];
    
    //include request body for PUT or POST
    if([methodString isEqualTo:@"POST"] || [methodString isEqualTo:@"PUT"])
    {
        NSString *reqBody = [requestTextView string];
        [*req_p setHTTPBody:[reqBody dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [*req_p setHTTPMethod:methodString];
    
}

- (IBAction)go:(NSButton *)sender {
    NSMutableURLRequest *req;
    NSError *requestError;
    NSHTTPURLResponse *urlResponse;
    [self setupRequest:&req urlResponse_p:&urlResponse];
   
    if([useBasicAuth state] == 1) {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", [basicAuthUsername stringValue], [basicAuthPassword stringValue]];
        NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodingWithLineLength:80]];
        [req setValue:authValue forHTTPHeaderField:@"Authorization"];
        
    }
    
    //make requst
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:req returningResponse:&urlResponse error:&requestError];
    
    //update response body
    [responseTextView setString:[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]];
    
    [self updateResponseHeaders:urlResponse];
    
    // Show the response body tab after request is made
    NSTabView *parentTabView = [responseTab tabView];
    [parentTabView selectTabViewItemAtIndex:(1)];
}

- (IBAction)addReqHeader:(id)sender {
    NSString *key = [addReqHeaderKeyText stringValue];
    NSString *value = [addReqHeaderValueText stringValue];
    if([[reqHeaderTableDatasource dictionary] count] <= 0){
        NSMutableDictionary *mutDictionary;
        mutDictionary = [NSMutableDictionary dictionary];
        [reqHeaderTableDatasource setDictionary:mutDictionary];
    }
    [reqHeaderTableDatasource setHeaderView:requestHeadersView];
    [reqHeaderTableDatasource addHeaderToTable:key value:value];
}
@end
