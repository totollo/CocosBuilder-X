//
//  SequenerButtonCell.m
//  SpriteBuilder
//
//  Created by John Twigg on 2013-11-18.
//
//

#import "SequencerButtonCell.h"
#import "SequencerHandler.h"

@implementation SequencerButtonCell

- (void) drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    if (!imagesLoaded)
    {
        imgRowBgChannel = [[NSImage imageNamed:@"seq-row-channel-bg.png"] retain];
        imagesLoaded = YES;
    }
    
    if (!_node)
    {
        NSRect rowRect = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + cellFrame.size.height - kCCBSeqDefaultRowHeight, cellFrame.size.width+20, kCCBSeqDefaultRowHeight);
        [imgRowBgChannel drawInRect:rowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
        return;
    }

    [super drawWithFrame:cellFrame inView:controlView];
}

-(void)setEnabled:(BOOL)flag
{
    [super setEnabled:flag];
    
    if(![self isEnabled])
    {
        if (self.type == 0) {
            self.image = [NSImage imageNamed:@"seq-visible-faint.png"];
        }else{
            self.image = [NSImage imageNamed:@"seq-notset.png"];
        }
        
    }
    else
    {
        if (self.type == 0) {
            self.image = [NSImage imageNamed:@"seq-visible.png"];
        }else{
            self.image = [NSImage imageNamed:@"seq-locked.png"];
        }
        
    }
    
}

-(void)setNode:(CCNode *)node{
    _node = node;
//    [_node addObserver:self forKeyPath:@"visible" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(CCNode*)node{
    return _node;
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    [self setEnabled:!_node.visible];
//}

-(void)dealloc{
//    [_node removeObserver:self forKeyPath:@"visible"];
    [super dealloc];
}

@end
