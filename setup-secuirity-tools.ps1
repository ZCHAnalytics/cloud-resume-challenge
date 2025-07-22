# Setup script for Windows local agent
Write-Host "Setting up security scanning tools..." -ForegroundColor Green

# Check Python
if (!(Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Error "Python not found! Please install Python 3.x"
    exit 1
}

# Upgrade pip
python -m pip install --upgrade pip

# Install security tools
pip install semgrep bandit[toml] detect-secrets safety

# Verify installations
Write-Host "`nVerifying installations:" -ForegroundColor Yellow
semgrep --version
bandit --version
detect-secrets --version
safety --version

Write-Host "`nSetup complete!" -ForegroundColor Green

# Command .\setup-security-tools.ps1