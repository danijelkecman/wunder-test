//
//  MainPresenter.swift
//  WunderTest
//
//  Created by Danijel Kecman on 11/5/18.
//  Copyright (c) 2018 Danijel Kecman. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MainPresenter {

    // MARK: - Private properties -

    private unowned var _view: MainViewInterface
    private var _interactor: MainInteractorInterface
    private var _wireframe: MainWireframeInterface

    // MARK: - Lifecycle -

    init(wireframe: MainWireframeInterface, view: MainViewInterface, interactor: MainInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -

extension MainPresenter: MainPresenterInterface {
}
