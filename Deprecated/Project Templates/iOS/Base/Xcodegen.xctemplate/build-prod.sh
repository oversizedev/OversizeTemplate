sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/' "Packages/App/Package.swift"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/' "Packages/Database/Package.swift"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/' "Packages/Env/Package.swift"

xcodegen --spec projectProd.yml
