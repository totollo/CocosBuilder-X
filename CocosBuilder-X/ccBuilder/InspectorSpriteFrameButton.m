//
//  InspectorSpriteFrameButton.m
//  CocosBuilder
//
//  Created by Higgx on 12/13/13.
//
//

#import "InspectorSpriteFrameButton.h"
#import "InspectorSpriteFrame.h"

@implementation InspectorSpriteFrameButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender{
    return NSDragOperationGeneric;
}

-(BOOL)performDragOperation:(id<NSDraggingInfo>)sender{
    NSPoint pt = [self convertPoint:[sender draggingLocation] fromView:NULL];
    pt = NSMakePoint(roundf(pt.x),roundf(pt.y));
    
    NSPasteboard* pb = [sender draggingPasteboard];
    if (pb)
    {
        [_root setDragValue:pb];
    }
    
    return YES;
}

@end
