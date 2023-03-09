import UIKit

final class SettingsViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
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
        let stringCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, string in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = string
            cell.contentConfiguration = configuration
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, string in
                return collectionView.dequeueConfiguredReusableCell(using: stringCellRegistration, for: indexPath, item: string)
            }
        )
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(["Licenses"], toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SettingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch dataSource.itemIdentifier(for: indexPath) {
        case "Licenses":
            navigationController?.pushViewController(LicensesViewController(), animated: true)
        default:
            break
        }
    }
}
