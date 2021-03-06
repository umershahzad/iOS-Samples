//
//  ViewController.h
//  UIElementsSample
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2013 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

#import <UIKit/UIKit.h>
#import "BETableView.h"
#import "BECollectionView.h"

@interface ViewController : UIViewController
//@property (nonatomic, weak) IBOutlet BEMapView *mapView;
@property (nonatomic, weak) IBOutlet BETableView *tableview;
@property (nonatomic, weak) IBOutlet BECollectionView *collectionView;
@end
