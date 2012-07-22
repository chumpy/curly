//
//  CurlyDocument.h
//  Curly
//
//  Created by Kevin Beddingfield on 4/12/12.
//  Copyright (c) 2012 Kevin Beddingfield. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HeaderTableDatasource.h"
#import "NSData+Base64.h"


@interface CurlyDocument : NSDocument
@property (weak) IBOutlet NSTextField *url;
- (IBAction)go:(NSButton *)sender;
@property (weak) IBOutlet NSPopUpButton *method;
@property (weak) IBOutlet NSTabViewItem *responseTab;
@property (weak) IBOutlet NSTableView *requestHeadersView;

@property (unsafe_unretained) IBOutlet NSTextView *responseTextView;

@property (unsafe_unretained) IBOutlet NSTextView *requestTextView;
@property (weak) IBOutlet NSTableView *responseHeadersView;
@property (strong) IBOutlet HeaderTableDatasource *headerTableDatasource;
@property (strong) IBOutlet HeaderTableDatasource *reqHeaderTableDatasource;
@property (weak) IBOutlet NSTextField *addReqHeaderKeyText;


- (IBAction)addReqHeader:(id)sender;
@property (weak) IBOutlet NSTextField *addReqHeaderValueText;
@property (weak) IBOutlet NSButton *useBasicAuth;
@property (weak) IBOutlet NSTextField *basicAuthUsername;
@property (weak) IBOutlet NSTextField *basicAuthPassword;

@property NSMutableDictionary * root;
@end
