#import "VBPiePieceData.h"
#import "UIColor+HexColor.h"


@implementation VBPiePieceData

+ (UIColor*) defaultColors:(NSInteger)index {
    
    // It's better then just a random
    
    float deltaRed = 0;
    float deltaGreen = 0;
    float deltaBlue = 0;
    float alpha = 1;
    
    if (index > 7) {
        deltaRed = (arc4random() % 500)/2555.0f;
        deltaGreen = (arc4random() % 500)/2555.0f;
        deltaBlue = (arc4random() % 500)/2555.0f;
        index = index % 8;
    }
    
    switch (index) {
        case 0:
            return [UIColor colorWithRed:0.31+deltaRed green:0.74+deltaGreen blue:0.91+deltaBlue alpha:alpha];
        case 1:
            return [UIColor colorWithRed:0.33+deltaRed green:0.17+deltaGreen blue:0.48+deltaBlue alpha:alpha];
        case 2:
            return [UIColor colorWithRed:0.81+deltaRed green:0.61+deltaGreen blue:0.02+deltaBlue alpha:alpha];
        case 3:
            return [UIColor colorWithRed:0.43+deltaRed green:0.02+deltaGreen blue:0.46+deltaBlue alpha:alpha];
        case 4:
            return [UIColor colorWithRed:0.55+deltaRed green:0.77+deltaGreen blue:0.53+deltaBlue alpha:alpha];
        case 5:
            return [UIColor colorWithRed:0.00+deltaRed green:0.51+deltaGreen blue:0.08+deltaBlue alpha:alpha];
        case 6:
            return [UIColor colorWithRed:0.84+deltaRed green:0.66+deltaGreen blue:0.81+deltaBlue alpha:alpha];
        case 7:
            return [UIColor colorWithRed:0.73+deltaRed green:0.20+deltaGreen blue:0.63+deltaBlue alpha:alpha];
            
        default:
            return [UIColor colorWithRed:(arc4random() % 255)/255.0f green:(arc4random() % 255)/255.0f blue:(arc4random() % 255)/255.0f alpha:alpha];
    }
}

+ (VBPiePieceData*) pieceDataWith:(NSDictionary*)object {
    VBPiePieceData *data = [[VBPiePieceData alloc] init];
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *options = (NSDictionary*)object;
        data.name = options[@"name"];
        data.value = options[@"value"];
        
        id color = options[@"color"];
        if (color && [color isKindOfClass:[NSString class]]) {
            data.color = [UIColor colorWithHexString:color];
        } else if (color && [color isKindOfClass:[UIColor class]]) {
            data.color = color;
        }

        if (!data.color) {
            data.color = [self defaultColors:arc4random() % 10];
        }
        
        id labelColor = options[@"labelColor"];
        if (labelColor && [labelColor isKindOfClass:[NSString class]]) {
            data.labelColor = [UIColor colorWithHexString:labelColor];
        } else if (labelColor && [labelColor isKindOfClass:[UIColor class]]) {
            data.labelColor = labelColor;
        }
        if (!data.labelColor) {
            data.labelColor = [UIColor whiteColor];
        }
        
        id strokeColor = options[@"strokeColor"];
        if (strokeColor && [strokeColor isKindOfClass:[NSString class]]) {
            data.strokeColor = [UIColor colorWithHexString:strokeColor];
        } else if (strokeColor && [strokeColor isKindOfClass:[UIColor class]]) {
            data.strokeColor = strokeColor;
        }
        
        
        data.accent = [options[@"accent"] boolValue];
    } else {
        data.value = (NSNumber*)object;
        data.color = [self defaultColors:arc4random() % 10];
    }
    return data;
}
@end
