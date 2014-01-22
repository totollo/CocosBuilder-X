//
//  InspectorCCBFileButton.h
//  CocosBuilder
//
//  Created by Higgx on 12/13/13.
//
//

#import <Cocoa/Cocoa.h>

@class InspectorCCBFile;

@interface InspectorCCBFileButton : NSPopUpButton

@property (nonatomic,assign) InspectorCCBFile* root;

@end
