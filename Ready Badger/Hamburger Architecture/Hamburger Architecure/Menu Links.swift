/*
 * Copyright 2016 UW-Parkside AppFactory
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import UIKit

enum MenuLinks: String {
    
    case MakeAList = "Make A List"
    case BasicKit = "Basic Kit"
    case PlanAhead = "Plan Ahead"
    case TypesOfDisasters = "Types of Disasters"
    case DamageReport = "Damage Report"
    case DisasterResources = "Disaster Resources"
    case SocialMedia = "Social Media"
    case Connect = "Connect"
    case AlertFeed = "Alert Feed"
    case RiverMap = "River Map"
    case EmergencyCenters = "Emergency Centers"
    case NearbyShelters = "Nearby Shelters"
    case AboutUs = "About Us"
    case EmergencyTone = "Emergency Tone"
    
    case SettingsSection = "Settings"
    case PreparedSection = "Be Prepared"
    case RespondSection = "Respond"
    case MonitorSection = "Monitor"
    case ShelterSection = "Take Shelter"
    case AboutSection = "About"
    
    
    static let allValues = [[AlertFeed, RiverMap], [DamageReport, DisasterResources, Connect, EmergencyTone], [MakeAList, BasicKit, PlanAhead, TypesOfDisasters], [AboutUs]]
    
    static let allSections = [MonitorSection, RespondSection, PreparedSection, AboutSection]
}
