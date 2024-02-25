#!/bin/bash

# Create Database package
mkdir Database
cd Database
swift package init --type library
echo "print(\"Hello from Database package!\")" > Sources/Database/Database.swift
cd ..

# Create Model package
mkdir Model
cd Model
swift package init --type library
echo "print(\"Hello from Model package!\")" > Sources/Model/Model.swift
cd ..

# Create Screens package
mkdir Screens
cd Screens
swift package init --type library
echo "print(\"Hello from Screens package!\")" > Sources/Screens/Screens.swift
cd ..

# Create main.swift in the main directory
echo "import Database" > main.swift
echo "import Model" >> main.swift
echo "import Screens" >> main.swift
echo "print(\"Swift code running!\")" >> main.swift

# Run Swift code
swift gen.swift
