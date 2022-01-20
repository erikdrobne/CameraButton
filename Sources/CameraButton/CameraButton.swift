import Foundation
import UIKit


public protocol CameraButtonDelegate: AnyObject {
    /// This method is called on button tap.
    func didTap(_ button: CameraButton)
    /// This method is called when progress reaches the end of duration.
    func didFinishProgress()
}

public class CameraButton: UIButton, CAAnimationDelegate {

    // MARK: - Private properties

    private let borderLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let shapeLayer = CAShapeLayer()

    private (set) public var isRecording = false

    /// This struct contains data for layer animations.
    private struct Animation {
        static let progress = (id: "progress", key: "strokeEnd", index: 0)
        static let tap = (id: "tap", key: "transform.scale", index: 1)
    }

    // MARK: - Public properties

    public weak var delegate: CameraButtonDelegate?
    public var borderColor = UIColor.white
    public var fillColor: (default: UIColor, record: UIColor) = (.white, .white)
    public var progressColor = UIColor.red
    public var progressDuration: TimeInterval = 5

    // MARK: - Initialization

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        setupBorderLayer()
        setupProgressLayer()
        setupShapeLayer()
    }

    // MARK: - Public methods

    /// CameraButton: start progress animation.
    public func start() {
        guard !isRecording else {
            return
        }

        isRecording = true
        borderLayer.opacity = 0
        progressLayer.opacity = 1
        shapeLayer.fillColor = fillColor.record.cgColor

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: ({
            self.backgroundColor = self.fillColor.record.withAlphaComponent(0.6)
        }), completion: { _ in
            self.animateProgress(duration: self.progressDuration)
        })
    }

    /// CameraButton: stop progress animation.
    public func stop() {
        guard isRecording else {
            return
        }

        isRecording = false
        progressLayer.opacity = 0
        borderLayer.opacity = 1
        shapeLayer.fillColor = fillColor.default.cgColor

        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: ({
            self.backgroundColor = .clear
        }), completion: { _ in
            self.clearProgressAnimation()
        })
    }

    // MARK: - Private methods

    private func setup() {
        clipsToBounds = false
        backgroundColor = .clear
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    private func setupBorderLayer() {
        layer.addSublayer(borderLayer)
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = frame.width * 0.05
        borderLayer.fillColor = nil
        borderLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)

        let diameter = frame.width
        let rect = CGRect(x: -diameter / 2, y: -diameter / 2, width: diameter, height: diameter)
        borderLayer.path = UIBezierPath(ovalIn: rect).cgPath
    }

    private func setupShapeLayer() {
        layer.addSublayer(shapeLayer)
        shapeLayer.fillColor = fillColor.default.cgColor
        shapeLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
        shapeLayer.path = UIBezierPath(ovalIn: rect(for: frame.width * 0.87)).cgPath
    }

    private func setupProgressLayer() {
        layer.addSublayer(progressLayer)
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = frame.width * 0.08
        progressLayer.opacity = 0
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = .round
        progressLayer.fillColor = nil
        progressLayer.position = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)

        let diameter = frame.width
        let path = UIBezierPath(
            roundedRect: rect(for: diameter),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: diameter, height: diameter)
        )

        progressLayer.path = path.cgPath
    }

    private func animateProgress(duration t: TimeInterval) {
        let animation = CABasicAnimation(keyPath: Animation.progress.key)
        animation.delegate = self
        animation.duration = t
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.setValue(Animation.progress.index, forKey: Animation.progress.id)
        progressLayer.strokeEnd = 1.0
        progressLayer.add(animation, forKey: Animation.progress.key)
    }

    private func clearProgressAnimation() {
        progressLayer.removeAnimation(forKey: Animation.progress.key)
        progressLayer.strokeEnd = 0
        progressLayer.opacity = 0
        progressLayer.layoutIfNeeded()
    }

    private func animateTap(duration t: TimeInterval) {
        let animation = CABasicAnimation(keyPath: Animation.tap.key)
        animation.duration = t
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.toValue = [0.9, 0.9]
        animation.autoreverses = true
        animation.setValue(Animation.tap.index, forKey: Animation.tap.id)
        shapeLayer.add(animation, forKey: Animation.tap.key)
    }

    @objc private func handleTap(_ sender: CameraButton) {
        DispatchQueue.main.async { [weak self] in
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            self?.animateTap(duration: 0.15)
            self?.delegate?.didTap(sender)
        }
    }

    // MARK: - Utilities

    private func rect(for diameter: CGFloat) -> CGRect {
        return CGRect(x: -diameter / 2, y: -diameter / 2, width: diameter, height: diameter)
    }

    // MARK: - CAAnimationDelegate

    public func animationDidStop(_ animation: CAAnimation, finished flag: Bool) {
        guard
            flag,
            animation.value(forKey: Animation.progress.id) as? Int == Animation.progress.index
        else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.stop()
            self?.delegate?.didFinishProgress()
        }
    }
}
