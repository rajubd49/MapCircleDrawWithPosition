//
//  ViewController.m
//  MapCircleDrawWithPosition
//
//  Created by MAC on 4/16/15.
//  Copyright (c) 2015 APPBD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSDictionary *fillColorDict;
    NSDictionary *strokeColorDict;
    UIPickerView *fillColorPickerView;
    UIPickerView *strokeColorPickerView;
}

@end

@implementation ViewController

@synthesize mapView = _mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    _mapView.showsUserLocation = YES;
    
    self.circleCoordinate = CLLocationCoordinate2DMake( 23.836468, 90.369539 );
    self.circleRadius = 3000;
    self.circleRadiusMax = 25000;
    [self updateMapRegionForMapSelector];
    
    fillColorDict = @{@"Orange": [UIColor orangeColor], @"Green": [UIColor greenColor],  @"Pure": [UIColor purpleColor],  @"Cyan": [UIColor cyanColor], @"Yellow": [UIColor yellowColor],  @"Magenta": [UIColor magentaColor]};
    strokeColorDict = @{@"Dark Gray": [UIColor darkGrayColor], @"Black": [UIColor blackColor], @"Brown": [UIColor brownColor], @"Red": [UIColor redColor], @"Blue": [UIColor blueColor]};
    
    fillColorPickerView = [[UIPickerView alloc] init];
    fillColorPickerView.delegate = self;
    fillColorPickerView.dataSource = self;
    fillColorPickerView.showsSelectionIndicator = YES;
    
    strokeColorPickerView = [[UIPickerView alloc] init];
    strokeColorPickerView.delegate = self;
    strokeColorPickerView.dataSource = self;
    strokeColorPickerView.showsSelectionIndicator = YES;
    
    NSString *fillColorKey = @"Orange";
    _fillColorTextField.text = fillColorKey;
    self.fillColor = fillColorDict[fillColorKey];
    
    NSString *strokeColorKey = @"Dark Gray";
    _strokeColorTextField.text = strokeColorKey;
    self.strokeColor = strokeColorDict[strokeColorKey];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(inputAccessoryViewDidFinish)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setItems:@[doneButton] animated:NO];
    
    _fillColorTextField.inputView = fillColorPickerView;
    _fillColorTextField.inputAccessoryView = toolbar;
    
    _strokeColorTextField.inputView = strokeColorPickerView;
    _strokeColorTextField.inputAccessoryView = toolbar;
    
}

- (void)inputAccessoryViewDidFinish {
    [_fillColorTextField resignFirstResponder];
    [_strokeColorTextField resignFirstResponder];
}

- (IBAction)editingTypeSegmentedControlValueDidChange:(UISegmentedControl *)sender {
    self.editingType = sender.selectedSegmentIndex;
}

- (IBAction)fillingModeSegmentedControlValueDidChange:(UISegmentedControl *)sender {
    self.fillInside = (sender.selectedSegmentIndex == 0);
}

- (IBAction)hiddenSwitchValueDidChange:(UISwitch *)sender {
    self.hidden = !sender.on;
}

#pragma mark - DBMapSelectorViewController Delegate

- (void)mapSelectorViewController:(DBMapSelectorViewController *)mapSelectorViewController didChangeCoordinate:(CLLocationCoordinate2D)coordinate {
    _coordinateLabel.text = [NSString stringWithFormat:@"Coordinate = {%.2f, %.2f}", coordinate.latitude, coordinate.longitude];
}

- (void)mapSelectorViewController:(DBMapSelectorViewController *)mapSelectorViewController didChangeRadius:(CLLocationDistance)radius {
    NSString *radiusStr = (radius >= 1000) ? [NSString stringWithFormat:@"%.1f km", radius * .001f] : [NSString stringWithFormat:@"%.0f m", radius];
    _radiusLabel.text = [@"Radius = " stringByAppendingString:radiusStr];
}

#pragma mark - UIPickerView Delegate && DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSDictionary *dict = [pickerView isEqual:fillColorPickerView] ? fillColorDict : strokeColorDict;
    return dict.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *dict = [pickerView isEqual:fillColorPickerView] ? fillColorDict : strokeColorDict;
    return dict.allKeys[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDictionary *dict = [pickerView isEqual:fillColorPickerView] ? fillColorDict : strokeColorDict;
    NSString *colorKey = dict.allKeys[row];
    if ([pickerView isEqual:fillColorPickerView]) {
        self.fillColorTextField.text = colorKey;
        self.fillColor = fillColorDict[colorKey];
    } else if ([pickerView isEqual:strokeColorPickerView]) {
        self.strokeColorTextField.text = colorKey;
        self.strokeColor = strokeColorDict[colorKey];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
