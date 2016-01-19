//
//  VBCViewController.m
//  Charts
//
//  Created by Volodymyr Boichentsov on 15/02/2014.
//  Copyright (c) 2014 SAKrisT. All rights reserved.
//

#import "VBCViewController.h"
#import "UIColor+HexColor.h"
#import "VBPieChart.h"



@interface VBCViewController ()

@property (nonatomic, retain) VBPieChart *chart;

@property (nonatomic, retain) NSArray *chartValues;

@property (nonatomic) double progress;

@end

@implementation VBCViewController

- (IBAction)valueChangedSlider:(UISlider*)sender {
    
    float value = [sender value];
    
    switch (sender.tag) {
        case 0: {
            NSMutableArray *array = [NSMutableArray arrayWithArray:_chartValues];
            
            NSMutableDictionary *object = [NSMutableDictionary dictionaryWithDictionary:[array objectAtIndex:sender.tag]];
            [object setObject:[NSNumber numberWithFloat:sender.value] forKey:@"value"];
            [array replaceObjectAtIndex:sender.tag withObject:object];
            _chart.chartValues = array;
        }
            break;
            
        case 1:
            [_chart setRadiusPrecent:value];
            break;
        case 2:
            [_chart setHoleRadiusPrecent:value];
            break;
    }
    
}

- (void) chartInit {
    _progress = 0;
    
    if (!_chart) {
        _chart = [[VBPieChart alloc] init];
        [self.view addSubview:_chart];
    }
    [_chart setFrame:CGRectMake(10, 50, 300, 300)];
    [_chart setHoleRadiusPrecent:0.3];
    
    [_chart.layer setShadowOffset:CGSizeMake(2, 2)];
    [_chart.layer setShadowRadius:3];
    [_chart.layer setShadowColor:[UIColor blackColor].CGColor];
    [_chart.layer setShadowOpacity:0.7];
    _chart.startAngle = M_PI+M_PI_2;
    
    [_chart setHoleRadiusPrecent:0.3];
    
    [_chart setLabelsPosition:VBLabelsPositionOnChart];
    
    
//    [_chart setChartValues:@[
//                         @{@"name":@"first", @"value":@50, @"color":[UIColor redColor]},
//                         @{@"name":@"second", @"value":@20, @"color":[UIColor blueColor]},
//                         @{@"name":@"third", @"value":@40, @"color":[UIColor purpleColor]},
//                         ]
//                 animation:YES
//                  duration:0.5
//                   options:VBPieChartAnimationDefault];
    
    self.chartValues = @[
                         @{@"name":@"first", @"value":@50, @"color":[UIColor colorWithHex:0xdd191daa]},
                         @{@"name":@"sec", @"value":@20, @"color":[UIColor colorWithHex:0xd81b60aa]},
                         @{@"name":@"third", @"value":@40, @"color":[UIColor colorWithHex:0x8e24aaaa]},
                         @{@"name":@"fourth", @"value":@70, @"color":[UIColor colorWithHex:0x3f51b5aa]},
                         @{@"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa]},
                         @{@"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa]},
                         @{@"value":@34, @"color":[UIColor colorWithHex:0xb0bec5aa]},
                         @{@"name":@"stroke", @"value":@54, @"color":[UIColor colorWithHex:0xf57c00aa], @"strokeColor":[UIColor whiteColor]}
                         ];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setNeedsLayout];
    
    [self chartInit];
    
//    EXAMPLE for custom label position
//
//    [_chart setLabelsPosition:VBLabelsPositionCustom];
//    [_chart setLabelBlock:^CGPoint( CALayer *layer, NSInteger index) {
//        CGPoint p = CGPointMake(sin(-index/10.0*M_PI)*50+50, index*30);
//        return p;
//    }];
//    
//    self.chartValues = @[
//                         @{@"name":@"37%", @"value":@65, @"color":[UIColor colorWithHex:0x5677fcaa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"13%", @"value":@23, @"color":[UIColor colorWithHex:0x2baf2baa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"19.3%", @"value":@34, @"color":[UIColor colorWithHex:0xb0bec5aa], @"labelColor":[UIColor blackColor]},
//                         @{@"name":@"30.7%", @"value":@54, @"color":[UIColor colorWithHex:0xf57c00aa], @"labelColor":[UIColor blackColor]}
//                         ];
    
    
    
    [_chart setChartValues:_chartValues animation:YES];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction) changeSec:(id)sender {
    [_chart setValue:@(100) pieceAtIndex:1];
}

- (IBAction) removeSecond:(id)sender {
    [_chart removePieceAtIndex:1];
    
//    [_chart insertChartValue:@{@"name":@"", @"value":@30} atIndex:1];
}

- (IBAction) progressExample:(id)sender {
    
    _chart.layer.borderWidth = 0;
    [_chart setHoleRadiusPrecent:0.95];
    
    [_chart.layer setShadowOffset:CGSizeMake(0, 0)];
    [_chart.layer setShadowRadius:0];
    [_chart.layer setShadowColor:[UIColor whiteColor].CGColor];
    [_chart.layer setShadowOpacity:0.0];

    self.chartValues = @[
                         @{@"name":@"", @"value":@100, @"color":[UIColor colorWithHex:0xffffffff]},
                         @{@"name":@"", @"value":@0, @"color":[UIColor colorWithHex:0xdd191daa]},];

     [_chart setChartValues:_chartValues animation:NO];
    [self progressAction];
}

- (void) progressAction {
    _progress += 0.25;
    
    [CATransaction setAnimationDuration:0.0167];
    if (_progress < 100) {
        [CATransaction setCompletionBlock:^{
            [self progressAction];
        }];
    }

    [_chart setValues:@{@(0) : @(100-_progress),
                        @(1) : @(_progress)}];
    
    if (_progress == 100) {
        _progress = 0;
    }
}


- (IBAction) growthAll:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationGrowthAll | VBPieChartAnimationTimingEaseInOut];
}

- (IBAction) growth:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowth];
}

- (IBAction) growthBackAll:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:0.4 options:VBPieChartAnimationGrowthBackAll | VBPieChartAnimationTimingEaseInOut];
}

- (IBAction) growthBack:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:1.0 options:VBPieChartAnimationGrowthBack];
}


- (IBAction) fan:(id)sender {
    
    [_chart setChartValues:_chartValues animation:YES duration:0.4 options:VBPieChartAnimationFan];
}


- (IBAction) fanAll:(id)sender {

    [_chart setChartValues:_chartValues animation:YES options:VBPieChartAnimationFanAll];
}

- (IBAction) changeLenght:(id)sender {
    if (_chart.length < M_PI*2-0.01) {
        _chart.length = M_PI*2;
        _chart.startAngle = 0;
    } else {
        _chart.length = M_PI;
        _chart.startAngle = M_PI;
    }
    
    [_chart setChartValues:_chartValues animation:YES];
    
}


//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    UITouch *t = [[touches allObjects] lastObject];
//    CGPoint p1 = [t previousLocationInView:self.view];
//    CGPoint p2 = [t locationInView:self.view];
//    
//    CGPoint delta;
//    delta.x = p1.x - p2.x;
//    delta.y = p1.y - p2.y;
//    
//    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.y * M_PI / 180.0f, 1, 0, 0);
////    self.layer.transform = CATransform3DRotate(self.layer2.transform, delta.y * M_PI / 180.0f, 1, 0, 0);
//
//    _chart.layer.transform = CATransform3DRotate(_chart.layer.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
////    self.layer2.transform = CATransform3DRotate(self.layer2.transform, delta.x * M_PI / 180.0f, 0, -1, 0);
//
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
