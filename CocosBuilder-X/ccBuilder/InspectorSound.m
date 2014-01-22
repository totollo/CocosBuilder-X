//
//  InspectorSound.m
//  CocosBuilder
//
//  Created by Higgx on 12/26/13.
//
//

#import "InspectorSound.h"

#import "TexturePropertySetter.h"
#import "CCBGlobals.h"
#import "ResourceManager.h"
#import "ResourceManagerUtil.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation InspectorSound

- (void) willBeAdded
{
    // Setup menu
    NSString* sound = [TexturePropertySetter soundForNode:selection andProperty:propertyName];
    [ResourceManagerUtil populateResourcePopup:popup resType:kCCBResTypeAudio allowSpriteFrames:NO selectedFile:sound selectedSheet:NULL target:self];
}

- (void) selectedResource:(id)sender
{
    [[AppDelegate appDelegate] saveUndoStateWillChangeProperty:propertyName];
    
    id item = [sender representedObject];
    
    // Fetch info about the sprite name
    NSString* sound = NULL;
    
    if ([item isKindOfClass:[RMResource class]])
    {
        RMResource* res = item;
        
        if (res.type == kCCBResTypeAudio)
        {
            sound = [ResourceManagerUtil relativePathFromAbsolutePath:res.filePath];
            [ResourceManagerUtil setTitle:sound forPopup:popup];
        }
    }
    
    // Set the properties and sprite frames
    if (sound)
    {
        [TexturePropertySetter setSoundForNode:selection andProperty:propertyName withFile:sound];
    }
    
    [self updateAffectedProperties];
}
- (IBAction)menuClick:(id)sender {
    NSSegmentedControl* sc = sender;
    
    int tag = [sc selectedSegment];
    if (tag == 0) {
        NSString* sound = [TexturePropertySetter soundForNode:selection andProperty:propertyName];
        NSString* absFile = [[AppDelegate appDelegate].resManager toAbsolutePath:sound];
        NSLog(@"play sound : %@",sound);
        sid = [[SimpleAudioEngine sharedEngine] playEffect:absFile];
    }else if (tag ==1){
        [[SimpleAudioEngine sharedEngine] stopEffect:sid];
    }
}

@end
