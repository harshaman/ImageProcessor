//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")!

// Process the image!
class ImageProcessor {
    var image: RGBAImage
    var avgRed = 0
    var avgGreen = 0
    var avgBlue = 0
    
    init(image:UIImage){
        self.image = RGBAImage(image: image)!
    }
    
    func filterImg(filter:[String]) {
        self.getAverages(self.image)
        for option in filter {
            switch option.lowercaseString {
                case "skyline":
                    self.skyline(self.image)
                case "toaster":
                    self.toaster(self.image)
                case "brightness50":
                    self.brightness50(self.image, percent: 50)
                case "grayscale":
                    self.grayscale(self.image)
                default:
                    print(option.lowercaseString, "is not supported")
            
        }
    }
}

func getAverages(image: RGBAImage) {
    
    var totalRed = 0
    var totalGreen = 0
    var totalBlue = 0

    for row in 0..<image.height {
        for col in 0..<image.width {
            let index = row * image.width + col
            var pixel = image.pixels[index]
            totalRed += Int(pixel.red)
            totalGreen += Int(pixel.green)
            totalBlue += Int(pixel.blue)
        }
    }
    let count = image.width * image.height
    self.avgRed = totalRed/count
    self.avgGreen = totalGreen/count
    self.avgBlue = totalBlue/count
}

    func toaster(image: RGBAImage) {
        for row in 0..<self.image.height {
            for col in 0..<self.image.width {
                let index = row * self.image.width + col
                var pixel = self.image.pixels[index]
                let redDiff = Int(pixel.red) - avgRed
                if(redDiff > 0) {
                    pixel.red = UInt8( max (0, min (255, avgRed + redDiff * 2)))
                    pixel.blue = UInt8( max (0, min (255, avgBlue + redDiff / 2)))
                    self.image.pixels[index] = pixel
                }
            }
        }
    }
    
    
    func skyline(image: RGBAImage) {
        for row in 0..<self.image.height {
            for col in 0..<self.image.width {
                let index = row * self.image.width + col
                var pixel = self.image.pixels[index]
                let redDiff = Int(pixel.red) - avgRed
                if(redDiff > 0) {
                    pixel.red = UInt8( max (0, min (255, avgRed + redDiff / 2)))
                    pixel.blue = UInt8( max (0, min (255, avgBlue + redDiff * 2)))
                    self.image.pixels[index] = pixel
                }
            }
        }
    }
    
    func brightness50(image: RGBAImage , percent: Int) {
        let adjust = Double(percent) / 100
        for row in 0..<self.image.height {
            for col in 0..<self.image.width {
                let index = row * self.image.width + col
                var pixel = self.image.pixels[index]
                let red = round(Double(pixel.red) * adjust)
                let blue = round(Double(pixel.blue) * adjust)
                let green = round(Double(pixel.green) * adjust)
                pixel.red = UInt8( max (0, min (255, red)))
                pixel.blue = UInt8( max (0, min (255, blue)))
                pixel.green = UInt8( max (0, min (255, green)))
                self.image.pixels[index] = pixel
            }
        }
    }
    
    func grayscale(image: RGBAImage) {
        for row in 0..<self.image.height {
            for col in 0..<self.image.width {
                let index = row * self.image.width + col
                var pixel = self.image.pixels[index]
                let gray = 0.299 * Double(pixel.red) + 0.587 * Double(pixel.green) + 0.114 * Double(pixel.blue)
                let grayRounded = round(gray)
                pixel.red = UInt8(grayRounded)
                pixel.green = UInt8(grayRounded)
                pixel.blue = UInt8(grayRounded)
                self.image.pixels[index] = pixel
            }
        }
    }
    
    func toUIImage() -> UIImage {
        return self.image.toUIImage()!
    }
}

    let filter1 = ImageProcessor(image: image)
    let filter2 = ImageProcessor(image: image)
    let filter3 = ImageProcessor(image: image)
    
    filter1.filterImg(["skyline"])
    let processedImage1 = filter1.toUIImage()
    filter2.filterImg(["toaster"])
    let processedImage2 = filter2.toUIImage()
    filter3.filterImg(["brightness50","grayscale"])
    let processedImage3 = filter3.toUIImage()



