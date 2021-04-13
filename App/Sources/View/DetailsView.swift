//
//  DetailsView.swift
//  BreakingBad
//
//  Created by emile on 13/04/2021.
//

import UIKit
import Combine

final class DetailsView: UIViewController {
    
    let item: ListItem

    private let container = DetailsView.container
    private let indicator = DetailsView.indicator
    private let avatarView = DetailsView.avatarView
    private let nameLabel = DetailsView.bigLabel
    private let occupationLabel = DetailsView.bigLabel
    private let statusLabel = DetailsView.bigLabel
    private let nicknameLabel = DetailsView.bigLabel
    private let seasonsLabel = DetailsView.bigLabel
    private let nameTypeLabel = DetailsView.smallLabel
    private let occupationTypeLabel = DetailsView.smallLabel
    private let statusTypeLabel = DetailsView.smallLabel
    private let nicknameTypeLabel = DetailsView.smallLabel
    private let seasonsTypeLabel = DetailsView.smallLabel
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    init(item: ListItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureView()
    }
}

// MARK: - UI
private extension DetailsView {
    
    func setupView() {

        //
        view.backgroundColor = .white
        
        // Add views
        view.addSubview(container)
        
        avatarView.addSubview(indicator)
        
        container.addArrangedSubview(avatarView)
        
        container.addArrangedSubview(nameTypeLabel)
        container.addArrangedSubview(nameLabel)
        
        container.addArrangedSubview(occupationTypeLabel)
        container.addArrangedSubview(occupationLabel)
        
        container.addArrangedSubview(statusTypeLabel)
        container.addArrangedSubview(statusLabel)
        
        container.addArrangedSubview(nicknameTypeLabel)
        container.addArrangedSubview(nicknameLabel)
        
        container.addArrangedSubview(seasonsTypeLabel)
        container.addArrangedSubview(seasonsLabel)
        
        container.addArrangedSubview(UIView())
        setupLayout()
    }
    
    func setupLayout() {
        
        container.anchor(top: view.topAnchor, paddingTop: 100,
                         bottom: view.bottomAnchor, paddingBottom: 5,
                         left: view.leftAnchor, paddingLeft: 10,
                         right: view.rightAnchor, paddingRight: 10)
        
        indicator.anchor(centerX: avatarView.centerXAnchor, centerY: avatarView.centerYAnchor)
        avatarView.anchor(width: 200, height: 200)
        
    }
    
    func configureView() {
        
        // Image View
        cancellable = loadImage(for: item)
            .sink { [weak self] image in
                self?.showImage(image: image)
            }
        
        // LabelsType
        nameTypeLabel.text = "name"
        nameLabel.text = item.name
        
        occupationTypeLabel.text = "occupation"
        occupationLabel.text = item.occupation.joined(separator: ", ")
        
        statusTypeLabel.text = "status"
        statusLabel.text = item.status
        
        nicknameTypeLabel.text = "nickname"
        nicknameLabel.text = item.nickname
        
        seasonsTypeLabel.text = "seasons"
        seasonsLabel.text = item.season?.description
    }
}

// MARK: - ImageLoader
extension DetailsView: ImageLoaderInjected {

    private func showImage(image: UIImage?) {
        indicator.stopAnimating()
        avatarView.alpha = 0.0
        animator?.stopAnimation(false)
        avatarView.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3,
                                                                  delay: 0,
                                                                  options: .curveLinear,
                                                                  animations: {
                                                                    self.avatarView.alpha = 1.0
                                                                  })
    }
    
    private func loadImage(for item: ListItem) -> AnyPublisher<UIImage?, Never> {
        
        indicator.startAnimating()
        
        return Just(item.image)
            .flatMap { url -> AnyPublisher<UIImage?, Never> in
                self.imageLoader.loadImage(from: url)
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Components
private extension DetailsView {
    static var container: UIStackView {
        let stack = UIStackView(frame: CGRect.zero)
        stack.spacing = 10
        stack.alignment = .leading
        stack.axis = .vertical
        return stack
    }
    
    static var avatarView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        return imageView
    }
    
    static var smallLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }
    
    static var bigLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    static var indicator: UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
}
