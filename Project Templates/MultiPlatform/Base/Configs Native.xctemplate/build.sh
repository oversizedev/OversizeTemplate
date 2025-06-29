echo "Prepare Prod dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "Packages/App/Package.swift"

echo "Set Database dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "Packages/Database/Package.swift"

echo "Set Env dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "Packages/Env/Package.swift"

echo "Set OversizeAppStoreKit localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeAppStoreKit/Package.swift"

echo "Set OversizeAppStoreServices localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeAppStoreServices/Package.swift"

echo "Set OversizeComponents localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeComponents/Package.swift"

echo "Set OversizeKit localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeKit/Package.swift"

echo "Set OversizeModels localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeModels/Package.swift"

echo "Set OversizeNetwork localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeNetwork/Package.swift"

echo "Set OversizeRouter localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeRouter/Package.swift"

echo "Set OversizeServices localDependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/' "../Packages/OversizeServices/Package.swift"
