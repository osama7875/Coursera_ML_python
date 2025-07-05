#!/bin/bash

# n8n Google Sheets to Gmail Workflow Setup Script
# This script helps you quickly set up n8n and import the workflow

set -e

echo "🚀 n8n Google Sheets to Gmail Workflow Setup"
echo "=============================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if running on supported OS
check_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        print_error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    print_status "Detected OS: $OS"
}

# Check if Node.js is installed
check_node() {
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18 or later."
        print_status "Visit: https://nodejs.org/en/download/"
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2)
    MAJOR_VERSION=$(echo $NODE_VERSION | cut -d'.' -f1)
    
    if [ "$MAJOR_VERSION" -lt 18 ]; then
        print_error "Node.js version $NODE_VERSION is too old. Please install Node.js 18 or later."
        exit 1
    fi
    
    print_status "Node.js version: $NODE_VERSION ✓"
}

# Check if npm is installed
check_npm() {
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed. Please install npm."
        exit 1
    fi
    
    NPM_VERSION=$(npm --version)
    print_status "npm version: $NPM_VERSION ✓"
}

# Install n8n globally
install_n8n() {
    print_step "Installing n8n globally..."
    
    if command -v n8n &> /dev/null; then
        print_warning "n8n is already installed"
        N8N_VERSION=$(n8n --version)
        print_status "Current n8n version: $N8N_VERSION"
        
        read -p "Do you want to update n8n to the latest version? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            npm install -g n8n@latest
            print_status "n8n updated successfully"
        fi
    else
        npm install -g n8n
        print_status "n8n installed successfully"
    fi
}

# Create working directory
setup_directory() {
    print_step "Setting up working directory..."
    
    WORK_DIR="$HOME/n8n-workflow"
    
    if [ -d "$WORK_DIR" ]; then
        print_warning "Directory $WORK_DIR already exists"
        read -p "Do you want to continue and overwrite existing files? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Setup cancelled"
            exit 1
        fi
    else
        mkdir -p "$WORK_DIR"
        print_status "Created directory: $WORK_DIR"
    fi
    
    cd "$WORK_DIR"
}

# Copy workflow files
copy_workflow_files() {
    print_step "Copying workflow files..."
    
    # Check if workflow files exist in current directory
    if [ ! -f "n8n-google-sheet-email-workflow.json" ]; then
        print_error "Workflow file not found. Please ensure you have the workflow JSON file."
        exit 1
    fi
    
    # Copy files to working directory
    cp n8n-google-sheet-email-workflow.json "$WORK_DIR/"
    
    if [ -f "README-n8n-workflow.md" ]; then
        cp README-n8n-workflow.md "$WORK_DIR/"
    fi
    
    if [ -f "n8n-env-sample.env" ]; then
        cp n8n-env-sample.env "$WORK_DIR/.env"
        print_status "Environment file copied. Please edit .env with your settings."
    fi
    
    print_status "Workflow files copied to $WORK_DIR"
}

# Setup environment file
setup_environment() {
    print_step "Setting up environment configuration..."
    
    if [ ! -f ".env" ]; then
        print_warning "No .env file found. Creating a basic one..."
        cat > .env << 'EOF'
# Basic n8n configuration
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=change-this-password

# Host and port
N8N_HOST=localhost
N8N_PORT=5678
N8N_PROTOCOL=http

# Database (SQLite for development)
DB_TYPE=sqlite
DB_SQLITE_DATABASE=n8n.db

# Logging
N8N_LOG_LEVEL=info
N8N_LOG_OUTPUT=console

# Please update the following values:
# GOOGLE_OAUTH_CLIENT_ID=your-google-client-id
# GOOGLE_OAUTH_CLIENT_SECRET=your-google-client-secret
# GOOGLE_SHEET_ID=your-google-sheet-id
# GMAIL_RECIPIENT_EMAIL=recipient@gmail.com
EOF
        print_status "Created basic .env file"
    fi
    
    print_warning "Please edit the .env file with your Google OAuth credentials and other settings"
    print_status "You can edit it now or later: nano .env"
}

# Start n8n
start_n8n() {
    print_step "Starting n8n..."
    
    print_status "n8n will start with the following configuration:"
    print_status "- URL: http://localhost:5678"
    print_status "- Username: admin"
    print_status "- Password: change-this-password (update in .env)"
    print_status ""
    print_status "After n8n starts:"
    print_status "1. Open http://localhost:5678 in your browser"
    print_status "2. Login with the credentials above"
    print_status "3. Go to Workflows > Import from File"
    print_status "4. Select 'n8n-google-sheet-email-workflow.json'"
    print_status "5. Configure your credentials as described in the README"
    print_status ""
    
    read -p "Do you want to start n8n now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_status "Starting n8n... (Press Ctrl+C to stop)"
        n8n start
    else
        print_status "You can start n8n later with: n8n start"
    fi
}

# Display next steps
show_next_steps() {
    print_step "Next Steps:"
    echo ""
    echo "1. 📝 Edit the .env file with your configuration:"
    echo "   nano $WORK_DIR/.env"
    echo ""
    echo "2. 🔑 Set up Google OAuth credentials:"
    echo "   - Go to Google Cloud Console"
    echo "   - Create OAuth2 credentials"
    echo "   - Enable Google Sheets API and Gmail API"
    echo "   - Add redirect URI: http://localhost:5678/rest/oauth2-credential/callback"
    echo ""
    echo "3. 🚀 Start n8n:"
    echo "   cd $WORK_DIR"
    echo "   n8n start"
    echo ""
    echo "4. 🌐 Open n8n in your browser:"
    echo "   http://localhost:5678"
    echo ""
    echo "5. 📥 Import the workflow:"
    echo "   Workflows > Import from File > n8n-google-sheet-email-workflow.json"
    echo ""
    echo "6. 📖 Read the detailed setup guide:"
    echo "   cat $WORK_DIR/README-n8n-workflow.md"
    echo ""
    print_status "Setup complete! 🎉"
}

# Main execution
main() {
    echo "Starting setup process..."
    echo ""
    
    check_os
    check_node
    check_npm
    install_n8n
    setup_directory
    copy_workflow_files
    setup_environment
    
    echo ""
    echo "🎉 Setup completed successfully!"
    echo ""
    
    read -p "Do you want to start n8n now? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        start_n8n
    else
        show_next_steps
    fi
}

# Run the main function
main "$@"