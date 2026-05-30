//
//  SettingsViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import StoreKit

final class SettingsViewController:
    BaseViewController {
    
    private let contentView =
    SettingsContentView()
    
    override func loadView() {
        
        view = contentView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupVersion()
        
        setupBindings()
    }
    
    private func setupVersion() {
        
        let version =
        Bundle.main.object(
            forInfoDictionaryKey:
                "CFBundleShortVersionString"
        ) as? String ?? "1.0.0"
        
        let build =
        Bundle.main.object(
            forInfoDictionaryKey:
                "CFBundleVersion"
        ) as? String ?? "1"
        
        contentView.versionLabel.text =
        "Version \(version) (\(build))"
    }
    
    private func setupBindings() {
        
        contentView.rateView.onTap = {
            [weak self] in
            
            self?.rateApp()
        }
        
        contentView.shareView.onTap = {
            [weak self] in
            
            self?.shareApp()
        }
        
        contentView.privacyView.onTap = {
            [weak self] in
            
            self?.openPrivacyPolicy()
        }
        
        contentView.aboutView.onTap = {
            [weak self] in
            
            self?.showAbout()
        }
    }
}

extension SettingsViewController {
    private func rateApp() {
        
        guard let scene =
                UIApplication.shared
            .connectedScenes
            .first as? UIWindowScene
        else {
            return
        }
        
        SKStoreReviewController
            .requestReview(
                in: scene
            )
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1
        ) {
            
            guard let url =
                    URL(
                        string:
                            AppConstants.reviewUrl
                    )
            else {
                return
            }
            
            UIApplication.shared.open(
                url
            )
        }
    }
    
    private func shareApp() {
        
        let text =
        """
        Check out ConvertTimer Pro
        
        \(AppConstants.appStoreUrl)
        """
        
        let activity =
        UIActivityViewController(
            activityItems: [text],
            applicationActivities: nil
        )
        
        present(
            activity,
            animated: true
        )
    }
    
    private func openPrivacyPolicy() {
        
        guard let url =
                URL(
                    string:
                        AppConstants.appStoreUrl
                )
        else {
            return
        }
        
        UIApplication.shared.open(
            url
        )
    }
    
    private func showAbout() {
        
        navigationController?
            .pushViewController(
                AboutViewController(),
                animated: true
            )
    }
}
