import UIKit

class ViewController: UIViewController {

    let firstButton = UIButton()
    let secButton = UIButton()
    let thirdButton = UIButton()

    var contries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    var moves = 0
    let totalMoves = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setFlagButtons()
        setButtonConstraints()
    }

    private func setFlagButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .done, target: self, action: nil)

        firstButton.layer.borderWidth = 1
        secButton.layer.borderWidth = 1
        thirdButton.layer.borderWidth = 1
        firstButton.layer.borderColor = UIColor.lightGray.cgColor
        secButton.layer.borderColor = UIColor.lightGray.cgColor
        thirdButton.layer.borderColor = UIColor.lightGray.cgColor

        firstButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        firstButton.tag = 0
        secButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        secButton.tag = 1
        thirdButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        thirdButton.tag = 2

        askQuestion()

        view.addSubview(firstButton)
        view.addSubview(secButton)
        view.addSubview(thirdButton)
        
    }

    private func setButtonConstraints() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        secButton.translatesAutoresizingMaskIntoConstraints = false
        thirdButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            firstButton.widthAnchor.constraint(equalToConstant: 200),
            firstButton.heightAnchor.constraint(equalToConstant: 100),
            firstButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            secButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 30),
            secButton.widthAnchor.constraint(equalToConstant: 200),
            secButton.heightAnchor.constraint(equalToConstant: 100),
            secButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            thirdButton.topAnchor.constraint(equalTo: secButton.bottomAnchor, constant: 30),
            thirdButton.widthAnchor.constraint(equalToConstant: 200),
            thirdButton.heightAnchor.constraint(equalToConstant: 100),
            thirdButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    private func askQuestion(action: UIAlertAction! = nil) {
        moves += 1
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Moves: \(moves)/\(totalMoves)", style: .done, target: self, action: nil)
        contries.shuffle()
        firstButton.setImage(UIImage(named: contries[0]), for: .normal)
        secButton.setImage(UIImage(named: contries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: contries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
        title = contries[correctAnswer].uppercased()
    }

    private func startNewGame(action: UIAlertAction!) {
        score = 0
        correctAnswer = 0
        moves = 0
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .done, target: self, action: nil)
        askQuestion()
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score: \(score)", style: .done, target: self, action: nil)

        let wrongMsg = "Wrong! that's the flag of \(contries[sender.tag].uppercased())."
        if moves == totalMoves {
            let msg = """
                \((title == "Wrong") ? wrongMsg : "Correct!")
                Your final score is: \(score).
                You are finished with \(moves) moves.
            """
            let alert = UIAlertController(title: "Game Ended", message: msg, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: startNewGame))
            present(alert, animated: true, completion: nil)
        } else {
            let msg = """
            \((title == "Wrong") ? wrongMsg : "")
            Your score is \(score).
            """
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alert, animated: true, completion: nil)
        }
    }
}

