//
//  ViewController.swift
//  SpotifyPlayerAutoLayout
//
//  Created by Tolga on 4.08.2021.
//

import UIKit

class ViewController: UIViewController {

    var stackView: UIStackView
    var playerView: PlayerView

    init() {
        stackView = makeStackView(withOrientation: .vertical)
        playerView = PlayerView()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerForOrientationChanges()
        setupViews()
    }

    func registerForOrientationChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    func setupViews() {
        stackView.addArrangedSubview(makeAlbumImageView())
        stackView.addArrangedSubview(makePlayerStackView())

        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: - Factory methods

    func makeAlbumImageView() -> UIImageView {
        let albumImage = makeImageView(named: "rush2")
        let heightAnchorConstraint = albumImage.heightAnchor.constraint(equalTo: albumImage.widthAnchor)
        heightAnchorConstraint.priority = .defaultHigh
        heightAnchorConstraint.isActive = true

        return albumImage
    }

    func makePlayerStackView() -> UIStackView {
        let stackView = makeStackView(withOrientation: .vertical)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)

        stackView.addArrangedSubview(playerView)

        return stackView
    }

    // MARK: - Rotation

    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }

        playerView.adjustForOrientiation()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}


