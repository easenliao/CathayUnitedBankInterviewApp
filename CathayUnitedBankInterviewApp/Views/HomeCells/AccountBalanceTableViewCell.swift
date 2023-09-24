//
//  AccountBalanceTableViewCell.swift
//  CathayUnitedBankInterviewApp
//
//  Created by 廖宜陞 on 2023/9/21.
//

import UIKit

// MARK: - AccountBalanceTableViewCell

class AccountBalanceTableViewCell: UITableViewCell {
    // MARK: - Private  Properties

    @IBOutlet var eyesImageView: UIImageView!
    @IBOutlet var eyesButton: UIButton!
    @IBOutlet var usdShimmerView: ShimmerView!
    @IBOutlet var usdLabel: UILabel!
    @IBOutlet var khrShimmerView: ShimmerView!
    @IBOutlet var khrLabel: UILabel!
    private var usdOriginalText = ""
    private var khrOriginalText = ""
    private let formatter = NumberFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        usdShimmerView.startAnimating()
        khrShimmerView.startAnimating()
        setNumberFormatter()
    }

    func setLoadingView(status: Bool) {
        usdShimmerView.isHidden = !status
        khrShimmerView.isHidden = !status
        usdLabel.isHidden = status
        khrLabel.isHidden = status
    }

    func toggleText() {
        toggleText(label: usdLabel, originalText: usdOriginalText)
        toggleText(label: khrLabel, originalText: khrOriginalText)
    }

    @IBAction func securityAction(_ sender: Any) {
        toggleText()
    }
}

// MARK: - Private Methods

private extension AccountBalanceTableViewCell {
    func toggleText(label: UILabel, originalText: String) {
        if label.text == originalText {
            eyesImageView.image = UIImage(named: "iconEye02Off")
            label.text = String(repeating: "*", count: 8)
        } else {
            eyesImageView.image = UIImage(named: "iconEye01On")
            label.text = originalText
        }
    }

    func setNumberFormatter() {
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
    }

    func setBalance(usd: Decimal, khr: Decimal) {
        guard let usdString = formatter.string(from: usd as NSNumber),
              let khrString = formatter.string(from: khr as NSNumber)
        else {
            return
        }
        usdOriginalText = usdString
        khrOriginalText = khrString
        usdLabel.text = usdOriginalText
        khrLabel.text = khrOriginalText
        eyesImageView.image = UIImage(named: "iconEye01On")
    }
}

extension AccountBalanceTableViewCell: ConfigurableCell {
    func configure(with model: HomeViewModel.MyAcconutViewType) {
        guard case let .accountBalance(amount) = model else {
            return
        }
        setBalance(usd: amount.usd, khr: amount.khr)
    }
}
