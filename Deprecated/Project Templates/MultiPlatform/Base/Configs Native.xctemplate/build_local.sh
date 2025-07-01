echo "Set App dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "Packages/App/Package.swift"

echo "Set Database dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "Packages/Database/Package.swift"

echo "Set Env dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "Packages/Env/Package.swift"

echo "Set OversizeAppStoreKit dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeAppStoreKit/Package.swift"

echo "Set OversizeAppStoreServices dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeAppStoreServices/Package.swift"

echo "Set OversizeComponents dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeComponents/Package.swift"

echo "Set OversizeKit dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeKit/Package.swift"

echo "Set OversizeModels dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeModels/Package.swift"

echo "Set OversizeNetwork dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeNetwork/Package.swift"

echo "Set OversizeRouter dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeRouter/Package.swift"

echo "Set OversizeServices dependencies"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = remoteDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = localDependencies/' "../Packages/OversizeServices/Package.swift"
