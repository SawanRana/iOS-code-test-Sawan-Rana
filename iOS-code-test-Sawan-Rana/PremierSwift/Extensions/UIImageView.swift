import UIKit

extension UIImageView {
    
    func dm_setImage(posterPath: String) {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w185/\(posterPath)")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }
        }
    }
    
    func dm_setImage(backdropPath: String) {
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w1280/\(backdropPath)")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                guard let data = data else { return }
                self.image = UIImage(data: data)
            }
        }
    }
    
}
