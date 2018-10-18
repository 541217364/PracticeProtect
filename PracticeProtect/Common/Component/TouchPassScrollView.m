//
//  TouchPassScrollView.m
//  MobileTravel
//
//  Created by  apple on 11-9-9.
//  Copyright 2011 egotour. All rights reserved.
//

#import "TouchPassScrollView.h"


@implementation TouchPassScrollView

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//	DNSLogMethod
	if (!self.dragging) {
		[self.nextResponder touchesBegan:touches withEvent:event];
	}
	else
		[super touchesEnded: touches withEvent: event];
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
//	DNSLogMethod
	if (!self.dragging) {
		[self.nextResponder touchesEnded:touches withEvent:event]; 
	}
	else
		[super touchesEnded: touches withEvent: event];
}

@end
