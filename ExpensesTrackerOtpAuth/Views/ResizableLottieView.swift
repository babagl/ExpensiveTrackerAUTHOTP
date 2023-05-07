//
//  ResizableLottieView.swift
//  Tabview
//
//  Created by Abdoulaye Aliou SALL on 06/05/2023.
//

import SwiftUI
import Lottie

struct ResizableLottieView: UIViewRepresentable {
    var lottieView : LottieAnimationView
    var color : SwiftUI.Color = .black
    
    func makeUIView(context : Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        addLottiesView(to: view)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context){
        //
        if let animationView = uiView.subviews.first(where: {view in
            view is LottieAnimationView
        }) as? LottieAnimationView{
            // finding keypath
//            lottieView.logHierarchyKeypaths()
            let lottieColor = ColorValueProvider(UIColor(color).lottieColorValue)
            // fill key path
            let fillKeyPath = AnimationKeypath(keys: ["**","Fill 1","**","Color"])
            animationView.setValueProvider(lottieColor, keypath: fillKeyPath)
            
            //stroke key path
            let strokeKeyPath = AnimationKeypath(keys: ["**","Stroke 1","**","Color"])
            animationView.setValueProvider(lottieColor, keypath: strokeKeyPath)
        }
    }
    
    func addLottiesView(to : UIView) {
        // memories Propreties
        
        lottieView.backgroundBehavior = .forceFinish
        lottieView.shouldRasterizeWhenIdle = true
        
        lottieView.backgroundColor = .clear
        lottieView.contentMode = .scaleAspectFit
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
    
}

