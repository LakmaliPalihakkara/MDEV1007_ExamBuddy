//
//  SubmissionObject.swift
//  Exam_Buddy
//
//  Created by Nirosha on 2022-11-09.
//  Copyright © 2022 Nirosha. All rights reserved.
//

import Foundation

struct SubmissionObject: Codable
{
    public var exam: String = ""
    public var course : String = ""
    public var type : String = ""
    public var date : String = ""
    public var done : Bool = false
}
