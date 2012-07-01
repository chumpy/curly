//
//  CurlyDocument.m
//  Curly
//
//  Created by Kevin Beddingfield on 4/12/12.
//  Copyright (c) 2012 Kevin Beddingfield. All rights reserved.
//

#import "CurlyDocument.h"


@implementation CurlyDocument
@synthesize method;
@synthesize responseTab;
@synthesize responseTextView;
@synthesize requestTextView;
@synthesize responseHeadersView;
@synthesize headerTableDatasource;
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

- (IBAction)go:(NSButton *)sender {
    NSURL *urlFromTextField = [NSURL URLWithString:[url stringValue]];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:urlFromTextField];
    [req setHTTPMethod:[method titleOfSelectedItem]];
    NSError *requestError;
    NSHTTPURLResponse *urlResponse = nil;
    NSData *returnData = [NSURLConnection  sendSynchronousRequest:req returningResponse:&urlResponse error:&requestError];
    [responseTextView setString:[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding]];  
    if ([urlResponse respondsToSelector:@selector(allHeaderFields)]) {
		NSDictionary *dictionary = [urlResponse allHeaderFields];
        [headerTableDatasource setHeaderView:responseHeadersView];
        [headerTableDatasource setDictionary:dictionary];
		[responseHeadersView reloadData];
	}
    
}

@end
