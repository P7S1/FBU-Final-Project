//
//  CameraViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <AVFoundation/AVFoundation.h>
#import "CameraViewController.h"

@interface CameraViewController ()

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) UIView *previewView;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self setUpAVSession];
}

//MARK:- Customising visual view elements
-(void) setUpView{
    self.previewView = [[UIView alloc]init];
    self.previewView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.previewView];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.previewView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.previewView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.previewView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.previewView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor]
    ]];
}

//MARK:- AVSession Setup
- (void)setUpAVSession{
    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!backCamera) {
        NSLog(@"Unable to access back camera!");
        return;
    }
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    if (!error) {
        self.stillImageOutput = [AVCapturePhotoOutput new];
        
        if ([self.captureSession canAddInput:input] && [self.captureSession canAddOutput:self.stillImageOutput]) {
            
            [self.captureSession addInput:input];
            [self.captureSession addOutput:self.stillImageOutput];
            [self setupLivePreview];
        }
    }
    else {
        NSLog(@"Error Unable to initialize back camera: %@", error.localizedDescription);
    }
}

- (void)setupLivePreview {
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    if (self.videoPreviewLayer) {
        
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.previewView.layer addSublayer:self.videoPreviewLayer];
        
        dispatch_queue_t globalQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(globalQueue, ^{
            [self.captureSession startRunning];
            //Size the Preview Layer to fit the Preview View
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoPreviewLayer.frame = self.previewView.bounds;
            });
            
        });
    }
}

@end
