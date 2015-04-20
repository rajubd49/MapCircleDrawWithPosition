//
//  ViewController.h
//  MapCircleDrawWithPosition
//
//  Created by MAC on 4/16/15.
//  Copyright (c) 2015 APPBD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBMapSelectorViewController.h"

@interface ViewController : DBMapSelectorViewController <DBMapSelectorViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UISwitch *hiddenSwitch;

@property (nonatomic, weak) IBOutlet UILabel *coordinateLabel;
@property (nonatomic, weak) IBOutlet UILabel *radiusLabel;

@property (nonatomic, weak) IBOutlet UISegmentedControl *editingTypeSegmentedControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *fillingModeSegmentedControl;

@property (nonatomic, weak) IBOutlet UITextField *fillColorTextField;
@property (nonatomic, weak) IBOutlet UITextField *strokeColorTextField;

@end

