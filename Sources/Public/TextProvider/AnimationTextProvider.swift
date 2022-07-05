//
//  AnimationImageProvider.swift
//  Lottie_iOS
//
//  Created by Alexandr Goncharov on 07/06/2019.
//

import Foundation

// MARK: - AnimationTextProvider

/// Text provider is a protocol that is used to supply text to `AnimationView`.
public protocol AnimationTextProvider: AnyObject {
  func textFor(keypathName: String, sourceText: String) -> String
}

// MARK: - DictionaryTextProvider

/// Text provider that simply map values from dictionary
public final class DictionaryTextProvider: AnimationTextProvider {

  // MARK: Lifecycle

  public init(_ values: [String: String]) {
    self.values = values
  }

  // MARK: Public

  public func textFor(keypathName: String, sourceText: String) -> String {
      let trimmedString = keypathName.trimmingCharacters(in: .whitespaces)
      print("keypathname==>\(trimmedString)")
      return values[caseInsensitive : trimmedString] ?? sourceText
  }

  // MARK: Internal

  let values: [String: String]
}

// MARK: - DefaultTextProvider

/// Default text provider. Uses text in the animation file
public final class DefaultTextProvider: AnimationTextProvider {

  // MARK: Lifecycle

  public init() {}

  // MARK: Public

  public func textFor(keypathName _: String, sourceText: String) -> String {
    sourceText
  }
}

extension Dictionary where Key == String {

    subscript(caseInsensitive key: Key) -> Value? {
        get {
            if let k = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) {
                return self[k]
            }
            return nil
        }
        set {
            if let k = keys.first(where: { $0.caseInsensitiveCompare(key) == .orderedSame }) {
                self[k] = newValue
            } else {
                self[key] = newValue
            }
        }
    }
}
