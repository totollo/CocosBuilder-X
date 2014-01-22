//
//  InspectorTimeLine.m
//  CocosBuilder
//
//  Created by Higgx on 12/18/13.
//
//

#import "InspectorTimeLine.h"

#import "CCBGlobals.h"
#import "ResourceManager.h"
#import "ResourceManagerUtil.h"
#import "AppDelegate.h"
#import "AnimationPropertySetter.h"
#import "CCNode+NodeInfo.h"

#import "NodeInfo.h"
#import "PlugInNode.h"
#import "SequencerNodeProperty.h"

#import "SequencerHandler.h"
#import "SequencerSequence.h"

#import "CCBPCCBFile.h"

@implementation InspectorTimeLine

- (void) willBeAdded
{
    // Setup menu
    SequencerSequence* seq = [SequencerHandler sharedHandler].currentSequence;
    NSArray* value = [selection valueForProperty:propertyName atTime:seq.timelinePosition sequenceId:seq.sequenceId];
    
    NSArray* seqs = [[(CCBPCCBFile*)selection ccbFile] extraPropForKey:@"*sequences"];
    
    NSMenu* menu = [popup menu];
    [menu removeAllItems];
    
    for (SequencerSequence* seq in seqs) {
        NSMenuItem* item = [[NSMenuItem alloc] initWithTitle:seq.name action:@selector(selectedResource:) keyEquivalent:@""];
        item.representedObject = seq.name;
        item.target = self;
        [menu addItem:item];
    }
    
//    NSLog(@"%@   %@",value[0],value[1]);
    NSString* title = value.count==0?@"":value[0];

    [ResourceManagerUtil setTitle:title forPopup:popup];
}

- (void) selectedResource:(id)sender
{
    [[AppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
    SequencerSequence* seq = [SequencerHandler sharedHandler].currentSequence;
    
    NSString* timeLine = [sender representedObject];
    NSNumber* time = [NSNumber numberWithFloat:seq.timelinePosition];
    NSArray* arr = [NSArray arrayWithObjects:timeLine,time, nil];
    
    [selection setExtraProp:arr forKey:propertyName];
    
    [self updateAnimateablePropertyValue:arr];
    
//    NodeInfo* nodeInfo = selection.userObject;
//    NSDictionary* dic = nodeInfo.animatableProperties;
//    SequencerNodeProperty* seq = [[dic objectForKey:[NSNumber numberWithInt:0]] objectForKey:@"timeLine"];
    
    [self updateAffectedProperties];
}

@end
