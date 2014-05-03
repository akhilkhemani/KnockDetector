//
//  GraphView.m
//  Accelerometer
//
//  Created by Joseph Conway on 28/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GraphView.h"
#define _AXIS_ORIGIN_X 20
#define _AXIS_ORIGIN_Y 145
#define _AXIS_LENGTH_X 460
#define _AXIS_LENGTH_Y -135


@implementation GraphView
@synthesize currentVC;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        flag = 1;
        KnockCount=0;
        knockIndicator = 0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef c = UIGraphicsGetCurrentContext();
	CGFloat green[4] = {0.0f, 1.0f, 0.0f, 1.0f};
	CGFloat red[4] = {1.0f, 0.0f, 0.0f, 1.0f};
	CGFloat blue[4] = {0.0f, 0.0f, 1.0f, 1.0f};
    CGFloat yellow[4] = {1.0f,1.0f,0.0f,1.0f};
	CGFloat white[4] = {1.0f, 1.0f, 1.0f, 1.0f};
	
	//draw axis
    CGContextSetStrokeColor(c, white);
    CGContextBeginPath(c);
	//top of y axis
    CGContextMoveToPoint(c, _AXIS_ORIGIN_X, _AXIS_ORIGIN_Y+_AXIS_LENGTH_Y);
	//bottom of y axis
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y);
	//origin
	CGContextMoveToPoint(c, _AXIS_ORIGIN_X, _AXIS_ORIGIN_Y);
	//end of x axis
    CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+_AXIS_LENGTH_X, _AXIS_ORIGIN_Y);
	CGContextStrokePath(c);
	
	//draw arrow heads
    CGContextBeginPath(c);
    //Y-Axis up
	CGContextMoveToPoint(c, _AXIS_ORIGIN_X-4, _AXIS_ORIGIN_Y+_AXIS_LENGTH_Y+7);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X, _AXIS_ORIGIN_Y+_AXIS_LENGTH_Y);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+4, _AXIS_ORIGIN_Y+_AXIS_LENGTH_Y+7);
	
	//X-axis right
	CGContextMoveToPoint(c, _AXIS_ORIGIN_X+_AXIS_LENGTH_X-5, _AXIS_ORIGIN_Y-4);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+_AXIS_LENGTH_X, _AXIS_ORIGIN_Y);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+_AXIS_LENGTH_X-5, _AXIS_ORIGIN_Y+4);
	CGContextStrokePath(c);
	
	//y-axis down
	CGContextMoveToPoint(c, _AXIS_ORIGIN_X-4, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y-7);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y);
	CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+4, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y-7);
	CGContextStrokePath(c);
	
	
		
	//plot points
	
	CGContextBeginPath(c);
	CGContextSetStrokeColor(c, red);
	CGContextSetFillColor(c, red);
	
	//X COORDS
	CGContextMoveToPoint(c, 20.0f, _AXIS_ORIGIN_Y);
	for (int i=1; i<[currentVC.plots count]; i++) {
		if ((25+2*i) < _AXIS_LENGTH_X) {
			UIAcceleration *a = [currentVC.plots objectAtIndex:i];
            UIAcceleration *a2 = [currentVC.plots objectAtIndex:i-1];
            float delta = fabsf(a.x - a2.x);
            
            //if(delta > 0.01) {
			//}
            NSString *temp = [NSString stringWithFormat:@"%.6f, %.6f", a.x, delta];
            
            if (flag == 0) {
                //NSLog(@"Delta X: %.6f", delta);
                writeStringValues = [NSString stringWithString: temp];
            }
            else {
                //NSLog(@"Delta X: N/A");
            }
            CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+2*i, _AXIS_ORIGIN_Y - (80*a.x));
		}
	}	
	CGContextStrokePath(c);
	
	//Y COORDINATES
	CGContextBeginPath(c);
	CGContextSetStrokeColor(c, blue);
	CGContextSetFillColor(c, blue);
	
	CGContextMoveToPoint(c, 20.0f, _AXIS_ORIGIN_Y);
	for (int i=1; i<[currentVC.plots count]; i++) {
		if ((25+2*i) < _AXIS_LENGTH_X) {
			UIAcceleration *a = [currentVC.plots objectAtIndex:i];
            UIAcceleration *a2 = [currentVC.plots objectAtIndex:i-1];
            float delta = fabsf(a.y - a2.y);
            
            NSString *temp = [NSString stringWithFormat:@"%.6f, %.6f", a.y, delta];
            if (flag == 0) {
                //NSLog(@"Delta Y: %.6f", delta);
                writeStringValues = [NSString stringWithString: temp];
            }
            else {
                //NSLog(@"Delta Y: N/A");
            }

			CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+2*i, _AXIS_ORIGIN_Y - (80*a.y));
		}
	}	
	CGContextStrokePath(c);
	
	//Z COORDINATES
	CGContextBeginPath(c);
	CGContextSetStrokeColor(c, green);
	CGContextSetFillColor(c, green);
	
	CGContextMoveToPoint(c, 20.0f, _AXIS_ORIGIN_Y);
	for (int i=1; i<[currentVC.plots count]; i++) {
		if ((25+2*i) < _AXIS_LENGTH_X) {
			UIAcceleration *a = [currentVC.plots objectAtIndex:i];
            UIAcceleration *a2 = [currentVC.plots objectAtIndex:i-1];
            float delta = fabsf(a.z - a2.z);
            
            CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+2*i, _AXIS_ORIGIN_Y - (80*a.z));
            
//            NSString *temp = [NSString stringWithFormat:@"%.6f, %.6f, \n", a.z, delta];
//            
//            if (flag == 0) {
//                //NSLog(@"Delta Z: %.6f", delta);
//                writeStringValues = [NSString stringWithString:temp];
//            }
//            else {
//                //NSLog(@"Delta Z: N/A");
//            }

            deltax = (a.x - a2.x);
            deltay = (a.y - a2.y);
            deltaz = (a.z - a2.z);
            total=0;
            
            total= deltax + deltay + deltaz;
            if((total<0) && (knockIndicator==1))
            {
                knockIndicator=0;
            }
            
            if (((total)>1.5) && (knockIndicator==0)) {
                
                KnockCount++;
                
                NSLog(@"Knock: %.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%i",total,a.x,deltax,a.y,deltay,a.z,deltaz,knockIndicator);
                [self knockDetected:KnockCount];
                
                currentVC.plots = [NSMutableArray arrayWithCapacity:0];
                currentVC.totals = [NSMutableArray arrayWithCapacity:0];
                [[currentVC view] setNeedsDisplay];
                
                knockIndicator=1;
                
                total=0;
                deltax=0;
                deltay=0;
                deltaz=0;
                
            }
            
			
		}
	}
	CGContextStrokePath(c);
	
    BOOL drawTotalAcceleration = NO;
    if(drawTotalAcceleration){
        //totals
        CGContextBeginPath(c);
        CGContextSetStrokeColor(c, yellow);
        CGContextSetFillColor(c, yellow);
        double lowPassResults;
        CGContextMoveToPoint(c, 20.0f, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y);
        for (int i=1; i<[currentVC.totals count]; i++) {
            if ((25+2*i) < _AXIS_LENGTH_X) {
                NSNumber *j = (NSNumber *) [currentVC.totals objectAtIndex:i];
                const double ALPHA = 0.1;
                double peakPowerForChannel = pow(10, (100 * j.doubleValue));
                double oldLowPass = lowPassResults;
                peakPowerForChannel = peakPowerForChannel * 50;
                lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * oldLowPass;
                CGContextAddLineToPoint(c, 25+2*i, _AXIS_ORIGIN_Y - (80*j.integerValue));
                //CGContextAddLineToPoint(c, _AXIS_ORIGIN_X+2*i, _AXIS_ORIGIN_Y-_AXIS_LENGTH_Y - lowPassResults);
                
                
            }
        }
        CGContextStrokePath(c);

    }
    
    
  
    
    
    
 
//      flag=1;
//    for(int i=2; (i<[currentVC.plots count]); i++) {
//        UIAcceleration *a = [currentVC.plots objectAtIndex:i];
//        UIAcceleration *a2 = [currentVC.plots objectAtIndex:i-2];
//        //total=0;
//        deltax = (a.x - a2.x);
//        deltay = (a.y - a2.y);
//        deltaz = (a.z - a2.z);
//        
//        total= deltax + deltay + deltaz;
//        
//        if ((total)>2.0) {
//            
//            KnockCount++;
//            NSLog(@"Knock: %.6f,%.6f,%.6f,%.6f,%.6f,%.6f,%.6f",total,a.x,deltax,a.y,deltay,a.z,deltaz);
//            total=0;
//            deltax=0;
//            deltay=0;
//            deltaz=0;
//            
//        }
//
//    }

    
//    if([currentVC.plots count] == 1100) {
//        [self printValues];
//    }
    
}



- (void) printValues {
    
    NSString *values;
    for(int i = 1; i<1100; i++) {
        UIAcceleration *a = [currentVC.plots objectAtIndex:i];
        UIAcceleration *a2 = [currentVC.plots objectAtIndex:i-1];
        float deltax2 = (a.x - a2.x);
        float deltay2 = (a.y - a2.y);
        float deltaz2 = (a.z - a2.z);
        
        NSLog(@", %.6f, %.6f, %.6f, %.6f, %.6f, %.6f", a.x, deltax2, a.y, deltay2, a.z, deltaz2);
    }
    
}

- (void) knockDetected: (int) count {
    NSLog(@"Knock #%i", count);
}

- (void)dealloc {
    [super dealloc];
}

-(NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"accelValues.csv"];
}

- (IBAction)saveAsFile:(id)sender {
    
    flag = 1;
    NSLog(@"ABCD %@",writeStringValues);
    //[self writeFile];

    
}

- (void) writeFile {
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
        NSLog(@"File Path Established & Created");
    }
    
    
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath] ];
    //say to handle where's the file to write
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    //position handle cursor to the end of file
    [handle writeData:[writeStringValues dataUsingEncoding:NSUTF8StringEncoding]];

    
}
@end
