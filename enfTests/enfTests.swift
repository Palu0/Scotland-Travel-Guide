//
//  enfTests.swift
//  enfTests
//
// 
//
import CoreLocation

import Testing

struct enfTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        if CLLocationManager.locationServicesEnabled() {
            print("uwu")
        }else {
                print("BLYATTTTTTTTTT!!!!!!!!!!!!!!!!!!!!!")
            }
        }
    }


