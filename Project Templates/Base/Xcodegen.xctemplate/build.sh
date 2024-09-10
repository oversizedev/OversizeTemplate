sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/' "Packages/App/Package.swift"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/' "Packages/Database/Package.swift"
sed -i '' 's/let dependencies: \[PackageDescription.Package.Dependency\] = productionDependencies/let dependencies: \[PackageDescription.Package.Dependency\] = developmentDependencies/' "Packages/Env/Package.swift"

xcodegen --spec project.yml
