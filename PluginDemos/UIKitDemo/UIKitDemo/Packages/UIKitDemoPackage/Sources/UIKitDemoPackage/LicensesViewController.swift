import UIKit

final class LicensesViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, LicensesPlugin.License>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Licenses"
        
        configureCollectionView()
        configureDataSource()
        
        applySnapshot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for selectedIndexPath in collectionView.indexPathsForSelectedItems ?? [] {
            collectionView.deselectItem(at: selectedIndexPath, animated: true)
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }
        collectionView = UICollectionView(frame: .null, collectionViewLayout: layout)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ]
        )
        
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let licenseCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, LicensesPlugin.License> { cell, indexPath, license in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = license.name
            cell.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, license in
                return collectionView.dequeueConfiguredReusableCell(using: licenseCellRegistration, for: indexPath, item: license)
            }
        )
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, LicensesPlugin.License>()
        snapshot.appendSections([.main])
        snapshot.appendItems(LicensesPlugin.licenses, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension LicensesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let license = dataSource.itemIdentifier(for: indexPath) else { return }
        navigationController?.pushViewController(LicenseDetailViewController(license: license), animated: true)
    }
}
