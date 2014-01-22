/*
 
 MGSFragaria
 Written by Jonathan Mitchell, jonathan@mugginsoft.com
 Find the latest version at https://github.com/mugginsoft/Fragaria
 
 Based on:
 
Smultron version 3.6b1, 2009-09-12
Written by Peter Borg, pgw3@mac.com
Find the latest version at http://smultron.sourceforge.net

Copyright 2004-2009 Peter Borg
 
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
 
http://www.apache.org/licenses/LICENSE-2.0
 
 
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
*/

#import "SMLStandardHeader.h"

#import "SMLGutterTextView.h"
#import "MGSFragaria.h"
#import "MGSBreakpointDelegate.h"
#import "SMLLineNumbers.h"
#import "SMLSyntaxError.h"
#import "SMLErrorPopOver.h"

@implementation SMLGutterTextView

#pragma mark -
#pragma mark Instance methods
/*
 
 - initWithFrame:
 
 */
- (id)initWithFrame:(NSRect)frame
{
	if ((self = [super initWithFrame:frame])) {
        
        imgBreakpoint0 = [MGSFragaria imageNamed:@"editor-breakpoint-0.png"];
        [imgBreakpoint0 setFlipped:YES];
        [imgBreakpoint0 retain];
        imgBreakpoint1 = [MGSFragaria imageNamed:@"editor-breakpoint-1.png"];
        [imgBreakpoint1 setFlipped:YES];
        [imgBreakpoint1 retain];
        imgBreakpoint2 = [MGSFragaria imageNamed:@"editor-breakpoint-2.png"];
        [imgBreakpoint2 setFlipped:YES];
        [imgBreakpoint2 retain];
        imgStopmarker = [MGSFragaria imageNamed:@"editor-stopmarker.png"];
        [imgStopmarker setFlipped:YES];
        [imgStopmarker retain];

		[self setContinuousSpellCheckingEnabled:NO];
		[self setAllowsUndo:NO];
		[self setAllowsDocumentBackgroundColorChange:NO];
		[self setRichText:NO];
		[self setUsesFindPanel:NO];
		[self setUsesFontPanel:NO];
		[self setAlignment:NSRightTextAlignment];
		[self setEditable:NO];
		[self setSelectable:NO];
		[[self textContainer] setContainerSize:NSMakeSize([[SMLDefaults valueForKey:@"GutterWidth"] integerValue], FLT_MAX)];
		[self setVerticallyResizable:YES];
		[self setHorizontallyResizable:YES];
		[self setAutoresizingMask:NSViewHeightSizable];
        
        NSMutableParagraphStyle * style = [[[NSMutableParagraphStyle alloc] init] autorelease];
        [style setAlignment:NSRightTextAlignment];
        [style setLineSpacing:1.0];
        [style setMinimumLineHeight:12.0];
        [style setMaximumLineHeight:12.0];
        [self setDefaultParagraphStyle:style];
        
        [self  setTypingAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                     [self defaultParagraphStyle],
                                     NSParagraphStyleAttributeName,
                                     [NSNumber numberWithFloat:-3],
                                     NSBaselineOffsetAttributeName,
                                     nil]];
        
        
        NSFont* font = [NSFont fontWithName:@"Menlo-Regular" size:9];
		[self setFont:font];
        
		[self setTextColor:[NSUnarchiver unarchiveObjectWithData:[SMLDefaults valueForKey:@"GutterTextColourWell"]]];
		[self setInsertionPointColor:[NSColor textColor]];

        
		[self setBackgroundColor:[NSColor colorWithCalibratedWhite:0.94f alpha:1.0f]];

		NSUserDefaultsController *defaultsController = [NSUserDefaultsController sharedUserDefaultsController];
		[defaultsController addObserver:self forKeyPath:@"values.TextFont" options:NSKeyValueObservingOptionNew context:@"TextFontChanged"];
	}
	return self;
}

#pragma mark -
#pragma mark KVO
/*
 
 - observeValueForKeyPath:ofObject:change:context:
 
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([(NSString *)context isEqualToString:@"TextFontChanged"]) {
		[self setFont:[NSUnarchiver unarchiveObjectWithData:[SMLDefaults valueForKey:@"TextFont"]]];
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

#pragma mark -
#pragma mark Drawing

/*
 
 - drawRect:
 
 */
- (void)drawRect:(NSRect)rect
{
	[super drawRect:rect];
	
    // Draw dotted line
	NSRect bounds = [self bounds]; 
	if ([self needsToDrawRect:NSMakeRect(bounds.size.width - 1, 0, 1, bounds.size.height)] == YES) {
		[[NSColor lightGrayColor] set];
		NSBezierPath *dottedLine = [NSBezierPath bezierPathWithRect:NSMakeRect(bounds.size.width, 0, 0, bounds.size.height)];
		CGFloat dash[2];
		dash[0] = 1.0f;
		dash[1] = 2.0f;
		[dottedLine setLineDash:dash count:2 phase:1.0f];
		[dottedLine stroke];
	}
    
    // Draw breakpoints
    if (self.breakpointLines)
    {
        for (NSNumber* lineNumber in self.breakpointLines)
        {
            int line = [lineNumber intValue];
            int yPos = line * 13 - 12;
            
            NSDrawThreePartImage(NSMakeRect(2, yPos, bounds.size.width -4, 12), imgBreakpoint0, imgBreakpoint1, imgBreakpoint2, NO, NSCompositeSourceOver, 1, NO);
            
            NSString* numberString = [NSString stringWithFormat:@"%d", (line + (int)self.lineNumberRange.location)];
            
            NSMutableParagraphStyle* paragraph = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
            [paragraph setAlignment:NSRightTextAlignment];
            
            NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSFont fontWithName:@"Menlo" size:9],
                                        NSFontAttributeName,
                                        [NSColor colorWithCalibratedRed:0.67f green:0.05f blue:0.57f alpha:1.0f],
                                        NSForegroundColorAttributeName,
                                        paragraph,
                                        NSParagraphStyleAttributeName,
                                        nil];
            
            [numberString drawInRect:NSMakeRect(0, yPos -1, bounds.size.width - 5, 10) withAttributes:attributes];
        }
    }
    
    // Draw highlighted line
    if (highlightedLine > 0 && highlightedLine >= (int)self.lineNumberRange.location && highlightedLine < (int)(self.lineNumberRange.location + self.lineNumberRange.length))
    {
        int yPos = (int)((highlightedLine - self.lineNumberRange.location) * 13 - 16);
        
        NSPoint highlightPos = NSMakePoint(5, yPos);
        
        [imgStopmarker drawAtPoint:highlightPos fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    }
}

- (void)mouseDown:(NSEvent *)theEvent
{
    NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSLayoutManager* lm = [self layoutManager];
    NSUInteger glyphIdx = [lm glyphIndexForPoint:curPoint inTextContainer:self.textContainer];
    
    NSUInteger charIdx = [lm characterIndexForGlyphAtIndex:glyphIdx];
    
    NSString* text = [self string];
    NSRange lineRange = [text lineRangeForRange:NSMakeRange(charIdx, 1)];
    NSString* substring = [text substringWithRange:lineRange];
    
    int lineNum = [substring intValue];
    
    id delegate = [[MGSFragaria currentInstance] objectForKey:MGSFOBreakpointDelegate];
    if (delegate && [delegate respondsToSelector:@selector(toggleBreakpointForFile:onLine:)])
    {
        [delegate toggleBreakpointForFile:self.fileName onLine:lineNum];
    }
    
    SMLLineNumbers* lineNumbers = [[MGSFragaria currentInstance] objectForKey:ro_MGSFOLineNumbers];
    
    [lineNumbers updateLineNumbersCheckWidth:NO recolour:NO];
    [self setNeedsDisplay:YES];
}

- (void) updateSyntaxErrors
{
    // Clear all buttons
    NSMutableArray* buttons = [NSMutableArray array];
    for (NSView* subview in [self subviews])
    {
        if ([subview isKindOfClass:[NSButton class]])
        {
            [buttons addObject:subview];
        }
    }
    for (NSButton* button in buttons)
    {
        [button removeFromSuperview];
    }
    
    // Add buttons for line errors
    for (SMLSyntaxError* err in self.syntaxErrors)
    {
        if (err.line > (int)(self.lineNumberRange.location) && err.line < (int)(self.lineNumberRange.location + self.lineNumberRange.length))
        {
            int yPosition = (int)(err.line * 13 - (self.lineNumberRange.location * 13) - 15);
            
            NSButton* warningButton = [[[NSButton alloc] initWithFrame:NSMakeRect(3, yPosition, 16, 16)] autorelease];
            
            [warningButton setButtonType:NSMomentaryChangeButton];
            [warningButton setBezelStyle:NSRegularSquareBezelStyle];
            [warningButton setBordered:NO];
            [warningButton setImagePosition:NSImageOnly];
            [warningButton setImage:[MGSFragaria imageNamed:@"editor-warning.png"]];
            [warningButton setTag:err.line];
            [warningButton setTarget:self];
            [warningButton setAction:@selector(pressedWarningBtn:)];
            
            [self addSubview:warningButton];
        }
    }
}

- (void) setHighlightedLine:(int)line
{
    highlightedLine = line;
    [self setNeedsDisplay:YES];
}

- (void) pressedWarningBtn:(id) sender
{
    int line = (int)[sender tag];
    
    // Fetch errors to display
    NSMutableArray* errorsOnLine = [NSMutableArray array];
    for (SMLSyntaxError* err in self.syntaxErrors)
    {
        if (err.line == line)
        {
            [errorsOnLine addObject:err.description];
        }
    }
    
    if (errorsOnLine.count == 0) return;
    
    [SMLErrorPopOver showErrorDescriptions:errorsOnLine relativeToView:sender];
}

/*
- (void)drawViewBackgroundInRect:(NSRect)rect
{
    [super drawViewBackgroundInRect:rect];
    
    //NSPoint containerOrigin = [self textContainerOrigin];
    NSLayoutManager* layoutManager = [self layoutManager];
    
    NSUInteger glyphIndex = [layoutManager glyphIndexForCharacterAtIndex:8];
    NSLog(@"glyphIndex: %d", (int)glyphIndex);
    
    //[layoutManager ch]
    
    NSPoint glyphLocation = [layoutManager locationForGlyphAtIndex:glyphIndex];
    NSLog(@"glyphLocation: %f,%f", glyphLocation.x, glyphLocation.y);
    
    NSRect bounds = [self bounds];
    
    NSLog(@"bounds: %f,%f,%f,%f", bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
    
    NSLog(@"img0: %@ img1: %@ img2: %@", imgBreakpoint0, imgBreakpoint1, imgBreakpoint2);
    
    //NSDrawThreePartImage(NSMakeRect(2, 110, bounds.size.width-4, 12), imgBreakpoint0, imgBreakpoint1, imgBreakpoint2, NO, NSCompositeSourceOver, 1, NO);
    
    [imgBreakpoint0 drawInRect:NSMakeRect(2, 110, 4, 12) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    [imgBreakpoint2 drawInRect:NSMakeRect(bounds.size.width-11, 110, 8, 12) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
}*/

/*
 
 - isOpaque
 
 */
- (BOOL)isOpaque
{
	return YES;
}

- (void) dealloc
{
    [imgBreakpoint0 release];
    [imgBreakpoint1 release];
    [imgBreakpoint2 release];
    [imgStopmarker release];
    self.fileName = NULL;
    self.breakpointLines = NULL;
    self.syntaxErrors = NULL;
    [super dealloc];
}

@end
