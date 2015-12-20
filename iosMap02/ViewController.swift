//
//  ViewController.swift
//  iosMap02
//
//  Created by MichaelXiao on 2015/12/8.
//  Copyright © 2015年 MichaelXiao. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!;//地圖元件
    var location : CLLocationManager!; //座標管理元件
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        location = CLLocationManager();
        location.delegate = self;
        
        //詢問使用者是否同意給APP定位功能
        location.requestWhenInUseAuthorization();
        //開始接收目前位置資訊
        location.startUpdatingLocation();
        location.distanceFilter = CLLocationDistance(10); //表示移動10公尺再更新座標資訊
    }
    
    //不執行時關閉定位功能
    override func viewDidDisappear(animated: Bool) {
       location.stopUpdatingLocation();
    }
    
    //編輯目前位置
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //取得目前的座標位置
        let c = locations[0]
        //c.coordinate.latitude 目前緯度
        //c.coordinate.longitude 目前經度
        let nowLocation = CLLocationCoordinate2D(latitude: c.coordinate.latitude, longitude: c.coordinate.longitude);

        //將map中心點定在目前所在的位置
        //span是地圖zoom in, zoom out的級距
        let _span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05);
        self.myMap.setRegion(MKCoordinateRegion(center: nowLocation, span: _span), animated: true);
        
        addPointAnnotation(c.coordinate.latitude, longitude: c.coordinate.longitude);
        

    }
    private func addPointAnnotation(latitude:CLLocationDegrees , longitude:CLLocationDegrees){
        //大頭針
        let point:MKPointAnnotation = MKPointAnnotation();
        //設定大頭針的座標位置
        point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude);
        point.title = "I'm here";
        point.subtitle = "緯度：\(latitude) 經度:\(longitude)";
        
        myMap.addAnnotation(point);
    }
    @IBAction func showActionSheet(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        
        let supportcityAction = UIAlertAction(title: "Support City", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Support City Page")
        })
        let settingAction = UIAlertAction(title: "Setting", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in

//                self.presentViewController(SettingViewTableViewController(), animated: true, completion: nil)
        
        })
        
        let aboutusAction = UIAlertAction(title: "About Us", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("About Us Page")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        
        optionMenu.addAction(supportcityAction)
        optionMenu.addAction(settingAction)
        optionMenu.addAction(aboutusAction)
        optionMenu.addAction(cancelAction)
        
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
}