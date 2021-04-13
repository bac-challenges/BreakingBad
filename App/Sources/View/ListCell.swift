//
//  ListCell.swift
//  BreakingBad
//
//  Created by emile on 04/04/2021.
//

import UIKit
import Combine

final class ListCell: UITableViewCell {
    
    private let container = ListCell.container
    private let indicator = ListCell.indicator
    private let avatarView = ListCell.avatarView
    private let nameLabel = ListCell.nameLabel
    
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetView()
    }
}

extension ListCell {
    func configure(_ item: ListItem) {
        
        // Image View
        cancellable = loadImage(for: item)
            .sink { [weak self] image in
                self?.showImage(image: image)
            }
        
        // Label
        self.nameLabel.text = item.name
    }
}

private extension ListCell {

    func setupView() {
        
        // Cell setup
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
        // Add views
        addSubview(container)
        
        avatarView.addSubview(indicator)
        
        container.addArrangedSubview(avatarView)
        container.addArrangedSubview(nameLabel)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        container.anchor(top: topAnchor, paddingTop: 5,
                         bottom: bottomAnchor, paddingBottom: 5,
                         left: leftAnchor, paddingLeft: 10,
                         right: rightAnchor, paddingRight: 10)
        
        indicator.anchor(centerX: avatarView.centerXAnchor, centerY: avatarView.centerYAnchor)
        avatarView.anchor(width: 50, height: 50)
        
    }
    
    func resetView() {
                
        // Labels
        nameLabel.text = ""
        
        // Image View
        avatarView.image = UIImage()
        cancellable?.cancel()
        animator?.stopAnimation(true)
    }
}

// MARK: - ImageLoader
extension ListCell: ImageLoaderInjected {
    
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
private extension ListCell {
    static var container: UIStackView {
        let stack = UIStackView(frame: CGRect.zero)
        stack.spacing = 10
        stack.alignment = .top
        stack.axis = .horizontal
        return stack
    }
    
    static var avatarView: UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }
    
    static var nameLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }
    
    static var indicator: UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
}
