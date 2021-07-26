//
//  CameraViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <AVFoundation/AVFoundation.h>
#import <TOCropViewController/TOCropViewController.h>
#import <CoreML/CoreML.h>
#import <Vision/Vision.h>
#import "MobileNet.h"
#import "CameraViewController.h"
#import "CreateListingViewController.h"
#import "BasicButton.h"

@interface CameraViewController() <AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) UIView *previewView;

@property (nonatomic, strong) BasicButton* photoLibraryButton;
@property (nonatomic, strong) BasicButton* captureButton;

@property (nonatomic, strong) UILabel* descriptorLabel;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpCameraPreviewView];
    [self setUpPhotoLibraryButton];
    [self setUpDescriptorLabel];
    self.view.backgroundColor = UIColor.blackColor;
    self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self setUpAVSession];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
}

- (void)launchCropViewControllerWithImage: (UIImage*)image{
    TOCropViewController* const vc = [[TOCropViewController alloc]initWithImage:image];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

//MARK:- Customising visual view elements
- (void)setUpDescriptorLabel{
    self.descriptorLabel = [[UILabel alloc]init];
    self.descriptorLabel.text = @"Descriptor Label";
    self.descriptorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptorLabel.textColor = UIColor.secondaryLabelColor;
    
    [self.view addSubview:self.descriptorLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.descriptorLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.descriptorLabel.topAnchor constraintEqualToAnchor:self.previewView.bottomAnchor constant:8]
    ]];
}

- (void)captureButtonPressed{
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

-(void)setUpCameraPreviewView{
    self.previewView = [[UIView alloc]init];
    self.previewView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.previewView];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.previewView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width],
        [self.previewView.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width * 1.33],
        [self.previewView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.previewView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

- (void)setUpPhotoLibraryButton{
    self.photoLibraryButton = [[BasicButton alloc]init];
    [self.photoLibraryButton setImage:[UIImage systemImageNamed:@"photo"] forState:UIControlStateNormal];
    [self.photoLibraryButton addTarget:self action:@selector(photoLibraryButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.photoLibraryButton.tintColor = UIColor.whiteColor;
    self.photoLibraryButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.photoLibraryButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.photoLibraryButton.heightAnchor constraintEqualToConstant:50],
        [self.photoLibraryButton.widthAnchor constraintEqualToConstant:50],
        [self.photoLibraryButton.bottomAnchor constraintEqualToAnchor:self.previewView.topAnchor constant:-16],
        [self.photoLibraryButton.centerXAnchor constraintEqualToAnchor:self.previewView.centerXAnchor]
    ]];
}

- (void)photoLibraryButtonPressed{
    UIImagePickerController* const pickerController = [[UIImagePickerController alloc]init];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
        [UIImagePickerController availableMediaTypesForSourceType:
            UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerController animated:YES completion:nil];
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
    AVCaptureDeviceInput* const input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
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

- (void)setupLivePreview{
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    if (self.videoPreviewLayer) {
        
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.previewView.layer addSublayer:self.videoPreviewLayer];
        
        dispatch_queue_t const globalQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(globalQueue, ^{
            [self.captureSession startRunning];
            //Size the Preview Layer to fit the Preview View
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoPreviewLayer.frame = self.previewView.bounds;
            });
            
        });
        
        dispatch_queue_attr_t const qos = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, -1);
        dispatch_queue_t const videoQueue = dispatch_queue_create("videoQueue", qos);
        
        AVCaptureVideoDataOutput *const dataOutput = [[AVCaptureVideoDataOutput alloc]init];
        [dataOutput setSampleBufferDelegate:self queue:videoQueue];
        [self.captureSession addOutput:dataOutput];
    }
}

//MARK:- AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error{
    
    NSData *imageData = photo.fileDataRepresentation;
    if (imageData) {
        UIImage* const image = [UIImage imageWithData:imageData];
        [self launchCropViewControllerWithImage:image];
    }
}

//MARK:- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* const image = info[UIImagePickerControllerOriginalImage];
    [self launchCropViewControllerWithImage:image];
}

//MARK:- TOCropViewControllerDelegat4e
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle{
    [cropViewController dismissViewControllerAnimated:YES completion:nil];
    CreateListingViewController* const vc = [[CreateListingViewController alloc]init];
    vc.listingImage = image;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK:- AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    struct __CVBuffer* const pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    if (pixelBuffer == nil) { return; }
    
    NSError* error;
    VNCoreMLModel* const model = [VNCoreMLModel modelForMLModel: [[MobileNet alloc]init].model error:&error];
    
    if (error != nil){
        NSLog(@"Error capturing ml model output: %@", [error localizedDescription]);
        return;
    }
    
    VNCoreMLRequest* request = [[VNCoreMLRequest alloc]initWithModel:model completionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
        if (error != nil){
            NSLog(@"Error constructing ml request: %@", [error localizedDescription]);
            return;
        }else{
            NSArray<VNClassificationObservation*>* results = [request.results sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                VNObservation* item1 = obj1;
                VNObservation* item2 = obj2;
                return item1.confidence < item2.confidence;
            }];
            
            if (results.count <= 0) { return; }
            
            VNClassificationObservation* topResult = results[0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.descriptorLabel.text = [[@"Are you trying to sell a " stringByAppendingString: topResult.identifier] stringByAppendingString:@"?"];
            });
        }
    }];
    
    [[[VNImageRequestHandler alloc]initWithCVPixelBuffer:pixelBuffer options:[NSDictionary new]] performRequests:@[request] error:&error];
}

@end
