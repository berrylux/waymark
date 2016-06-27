# Waymark
Drop-in navigation system for iOS apps.

## Goal
Navigation systems that takes care of navigation stack consistensy with easy-to-use API. 

**System that we actually would like to use in iOS apps.**

## Requirements
Waymark takes care of all navigation in iOS app including:
* decoupled presenting of View Controllers (they don't know about each other)
* injection of Model, ViewModel or Presenter into presented View Controller.
* URL based navigation (besides non-URL based) for handling of external navigation requests (from pushes or other aps)
* support of different types of menus simultaneously (no menu, hamburger menu, tab bar menu)
* support of modal presentation with priority levels
* support custom transitions;
* support percentage driven transitions.


## Architesture (Suggestion)
TODO
