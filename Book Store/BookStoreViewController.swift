//
//  BookStoreViewController.swift
//  Book Store
//
//  Created by Apple on 30/09/24.
//

import UIKit
import Kingfisher

class BookStoreViewController: UIViewController {

    @IBOutlet weak var productsCollectionView: UICollectionView!

    var parser = APIClient()
    var galleryArray: [Product] = [] // Changed to an array of Product

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        galleryGet()
    }

    // MARK: - SetUp View
    func setUpView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20

        productsCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    // MARK: - Web Services
    func galleryGet() {
        parser.request(URL_String: "https://apps.clickastro.com/test/products.php", MethodType: "GET", modelType: StoreProducts.self, parameters: [:]) { data, statusCode in
            if statusCode != 200 {
                self.dismiss(animated: true)
            } else {
                self.dismiss(animated: true)
                if let products = data.products {
                    // Convert Products object into an array of Product
                    self.galleryArray = self.extractAllProducts(from: products)
                    DispatchQueue.main.async {
                        self.productsCollectionView.reloadData()
                    }
                }
            }
        }
    }

    // Function to convert the Products object into an array of Product
    func extractAllProducts(from products: Products) -> [Product] {
        var allProducts = [Product]()
        
        if let yg = products.yg { allProducts.append(yg) }
        if let li = products.li { allProducts.append(li) }
        if let wl = products.wl { allProducts.append(wl) }
        if let cp = products.cp { allProducts.append(cp) }
        if let dt = products.dt { allProducts.append(dt) }
        if let gm = products.gm { allProducts.append(gm) }
        if let mr = products.mr { allProducts.append(mr) }
        if let mp = products.mp { allProducts.append(mp) }
        if let ed = products.ed { allProducts.append(ed) }
        if let ppol = products.ppol { allProducts.append(ppol) }
        if let pcol = products.pcol { allProducts.append(pcol) }
        if let bp = products.bp { allProducts.append(bp) }

        return allProducts
    }
}

// MARK: - CollectionView Delegate & DataSource
extension BookStoreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // Get the current product
        let product = galleryArray[indexPath.row]
        
        // Set the product name
        cell.titleLbl.text = product.name ?? "No name"
        
        // Set the product price
        if let price = product.price {
            cell.priceLbl.text = "Price: \(price)"
        } else {
            cell.priceLbl.text = "Price: N/A"
        }
        
        // Set the product image using Kingfisher
        if let imageUrl = product.imagePath?.square, let url = URL(string: imageUrl) {
            let downloadURL = KF.ImageResource(downloadURL: url)
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: downloadURL)
        } else {
            // Set a placeholder image if no image URL is available
            cell.imageView.image = UIImage(named: "placeholder")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle selection
    }
}

// MARK: - CollectionView Layouts
extension BookStoreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 15.0, bottom: 30.0, right: 15.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 2 - 20
        return CGSize(width: widthPerItem - 8, height: 230)
    }
}
