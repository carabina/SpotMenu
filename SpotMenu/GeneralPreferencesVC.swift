//
//  PreferencesWindow.swift
//  SpotMenu
//
//  Created by Miklós Kristyán on 2017. 05. 01..
//  Copyright © 2017. KM. All rights reserved.
//

import Foundation
import Cocoa
import Spotify


class GeneralPreferencesVC: NSViewController {
    
    @IBOutlet weak var showArtistButton: HoverButton!
    @IBOutlet weak var showTitleButton: HoverButton!
    @IBOutlet weak var showPlayingIconButton: HoverButton!
    @IBOutlet weak var showSpotMenuIconButton: HoverButton!
    @IBOutlet weak var fixPopoverToTheRightButton: HoverButton!
    
    @IBOutlet weak var openAtLoginButton: HoverButton!
    @IBOutlet weak var moreInformation: NSTextField!
    var defaultMoreInformationText: String = ""
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultMoreInformationText = moreInformation.stringValue
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        moreInformation.stringValue = defaultMoreInformationText
        initButtonStates()
        initButtonHovers()
    }
    
    func initButtonStates(){
        showArtistButton.state = UserPreferences.showArtist.asState
        showTitleButton.state =  UserPreferences.showTitle.asState
        showPlayingIconButton.state = UserPreferences.showPlayingIcon.asState
        showSpotMenuIconButton.state = UserPreferences.showSpotMenuIcon.asState
        fixPopoverToTheRightButton.state = UserPreferences.fixPopoverToTheRight.asState
        openAtLoginButton.state = applicationIsInStartUpItems().asState
    }
    
    func initButtonHovers(){
        showArtistButton.mouseEnteredFunc = hoverShowArtist
        showArtistButton.mouseExitedFunc = hoverAway
        
        showTitleButton.mouseEnteredFunc = hoverShowTitle
        showTitleButton.mouseExitedFunc = hoverAway
        
        showPlayingIconButton.mouseEnteredFunc = hoverShowPlayingIcon
        showPlayingIconButton.mouseExitedFunc = hoverAway
        
        showSpotMenuIconButton.mouseEnteredFunc = hoverShowSpotMenuIcon
        showSpotMenuIconButton.mouseExitedFunc = hoverAway
        
        fixPopoverToTheRightButton.mouseEnteredFunc = hoverFixPopoverToTheRight
        fixPopoverToTheRightButton.mouseExitedFunc = hoverAway
        
        openAtLoginButton.mouseEnteredFunc = hoverOpenAtLogin
        openAtLoginButton.mouseExitedFunc = hoverAway
    }
    
    @IBAction func toggleShowArtist(_ sender: Any) {
        UserPreferences.showArtist = showArtistButton.state.asBool
        postUpdateNotification()
    }
    
    @IBAction func toggleShowTitle(_ sender: Any) {
        UserPreferences.showTitle = showTitleButton.state.asBool
        postUpdateNotification()
    }
    
    @IBAction func toggleShowPlayingIcon(_ sender: Any) {
        UserPreferences.showPlayingIcon = showPlayingIconButton.state.asBool
        postUpdateNotification()
    }
    
    @IBAction func toggleShowSpotMenuIcon(_ sender: Any) {
        UserPreferences.showSpotMenuIcon = showSpotMenuIconButton.state.asBool
        postUpdateNotification()
        postUpdateNotification()
    }
    
    @IBAction func toggleFixPopoverToTheRight(_ sender: Any) {
        UserPreferences.fixPopoverToTheRight = fixPopoverToTheRightButton.state.asBool
        //postUpdateNotification()
    }
    
    @IBAction func toggleOpenAtLogin(_ sender: Any) {
        toggleLaunchAtStartup()
        openAtLoginButton.state = applicationIsInStartUpItems().asState
    }
    
    
    func postUpdateNotification(){
        NotificationCenter.default.post(name: Notification.Name(rawValue: InternalNotification.key), object: self)
    }
    
}

extension GeneralPreferencesVC {
    func hoverShowArtist() {
       moreInformation.stringValue = "When checked the Artist will be shown in the menu bar"
    }
    
    func hoverShowTitle() {
        moreInformation.stringValue = "When checked the Title will be shown in the menu bar"
    }
    
    func hoverShowPlayingIcon() {
        moreInformation.stringValue = "When checked the playing icon (♫) will be shown in the menu bar if the music is playing"
    }
    
    func hoverShowSpotMenuIcon() {
        moreInformation.stringValue = "When checked the SpotMenu icon will be shown in the menubar\n\nNote:\nIf there is no music information to be shown the SpotMenu icon will be visible"
    }
    
    func hoverFixPopoverToTheRight() {
        moreInformation.stringValue = "When checked the popover will be fixed to the right corner"
    }
    
    func hoverOpenAtLogin() {
        moreInformation.stringValue = "When checked SpotMenu will start automatically at login"
    }
    
    
    func hoverAway() {
        moreInformation.stringValue = defaultMoreInformationText
    }
}


