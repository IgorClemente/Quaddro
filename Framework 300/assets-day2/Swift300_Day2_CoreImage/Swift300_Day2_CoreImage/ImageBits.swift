//
//  ImageBits.swift
//  Swift300_Day2_CoreImage
//
//  Created by Nilo on 09/11/17.
//  Copyright © 2017 Nilo. All rights reserved.
//

import UIKit

extension UIImage {

    func changeBits(closure:(Int, Int, Pixel)->(Pixel)) -> UIImage {
        
        guard let cgimage = self.cgImage else {
            return self
        }
        
        let bytesPerPixel    = 4
        let bitsPerComponent = 8
        
        let width            = cgimage.width
        let height           = cgimage.height
        let colorSpace       = CGColorSpaceCreateDeviceRGB()
        let bytesPerRow      = bytesPerPixel * width
        let bitmapInfo       = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Little.rawValue

        guard let context = CGContext(
            data: nil,
            width: width, height: height,
            bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo) else {
            return self
        }
        
        context.draw(cgimage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        guard let buffer = context.data else {
            return self
        }
        
        let pixelBuffer = buffer.bindMemory(to: Pixel.self, capacity: width * height)
        
        for row in 0 ..< Int(height) {
            for column in 0 ..< Int(width) {
                let offset = row * width + column
                pixelBuffer[offset] = closure(row, column, pixelBuffer[offset])
            }
        }
        
        guard let outputCGImage = context.makeImage() else{
            return self
        }
        
        let outputImage = UIImage(cgImage: outputCGImage,
                                  scale: self.scale,
                                  orientation: self.imageOrientation)
        
        return outputImage
        
    }
    
    func copyImage(croppingTo newSize:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return croppedImage ?? self
    }
}


struct Pixel {
    
    var data: UInt32
    
    var red:CGFloat   { return CGFloat(UInt8((data >> 24) & 255))/255.0 }
    var green:CGFloat { return CGFloat(UInt8((data >> 16) & 255))/255.0 }
    var blue:CGFloat  { return CGFloat(UInt8((data >> 8)  & 255))/255.0 }
    var alpha:CGFloat { return CGFloat(UInt8((data >> 0)  & 255))/255.0 }
    
    init(data:UInt32) {
        self.data = data
    }
    
    init(fromHue hue: CGFloat, saturation:CGFloat, brightness:CGFloat){
        
        let color = UIColor(hue: hue, saturation: saturation,
                            brightness: brightness, alpha: 1.0)
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        data = 0
        data |= (UInt32(r*255) << 24)
        data |= (UInt32(g*255) << 16)
        data |= (UInt32(b*255) << 8)
        data |= (UInt32(a*255) << 0)
        
    }
    
    func toHUE() -> (hue:CGFloat, saturation:CGFloat, brightness:CGFloat) {
        let c = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        c.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h, s, b)
    }
    
    func change(hue:CGFloat, saturation:CGFloat) -> Pixel {
        
        var asHue = self.toHUE()
        
        asHue.hue += hue
        asHue.hue  = asHue.hue > 1 ? asHue.hue - 1 : asHue.hue
        asHue.hue  = asHue.hue < 0 ? 1 + asHue.hue : asHue.hue
        asHue.hue  = max(min(1.0, asHue.hue), 0.0)
        
        asHue.saturation += saturation
        asHue.saturation = max(min(1.0, asHue.saturation), 0.0)
        
        return Pixel(fromHue:    asHue.hue,
                     saturation: asHue.saturation,
                     brightness: asHue.brightness)
        
    }
    
}
