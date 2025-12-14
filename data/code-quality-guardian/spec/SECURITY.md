# Security - Vulnerability Assessment and Prevention

## Overview

Security assessment identifies vulnerabilities, prevents exploits, and ensures defensive coding practices. This guide covers OWASP Top 10, common vulnerabilities (CWE), and security best practices.

**Philosophy**: "Security is not optional" - build it in from the start.

## OWASP Top 10 (2021)

### 1. Broken Access Control

**Issue**: Users can access resources they shouldn't

**Examples**:

- Accessing `/admin` without admin role
- Viewing other users' data by changing ID in URL
- Elevation of privilege (user → admin)

**Prevention**:

```python
# ❌ Bad: No authorization check
@app.route('/user/<user_id>/data')
def get_user_data(user_id):
    return User.query.get(user_id).data

# ✅ Good: Verify ownership
@app.route('/user/<user_id>/data')
@login_required
def get_user_data(user_id):
    if current_user.id != user_id and not current_user.is_admin:
        abort(403)  # Forbidden
    return User.query.get(user_id).data
```

### 2. Cryptographic Failures

**Issue**: Sensitive data exposed due to weak crypto

**Examples**:

- Storing passwords in plain text
- Using MD5/SHA1 for passwords
- Transmitting sensitive data over HTTP
- Hardcoded encryption keys

**Prevention**:

```python
# ❌ Bad: Plain text password
user.password = request.form['password']

# ✅ Good: Hashed with bcrypt
import bcrypt
password_hash = bcrypt.hashpw(
    request.form['password'].encode(),
    bcrypt.gensalt(rounds=12)
)
user.password_hash = password_hash
```

### 3. Injection

**Issue**: Untrusted data sent to interpreter as command

**Types**:

- SQL Injection
- Command Injection
- XSS (Cross-Site Scripting)
- XXE (XML External Entity)

**SQL Injection Prevention**:

```python
# ❌ Bad: String interpolation
query = f"SELECT * FROM users WHERE name='{username}'"
# Exploit: username = "'; DROP TABLE users; --"

# ✅ Good: Parameterized query
query = "SELECT * FROM users WHERE name=?"
cursor.execute(query, (username,))
```

**XSS Prevention**:

```python
# ❌ Bad: Unescaped user input
return f"<h1>Welcome {request.args.get('name')}</h1>"
# Exploit: name = "<script>steal_cookies()</script>"

# ✅ Good: Template with auto-escaping
return render_template('welcome.html', name=request.args.get('name'))
```

### 4. Insecure Design

**Issue**: Missing security controls in design

**Examples**:

- No rate limiting (brute force attacks)
- Missing threat modeling
- Insufficient logging
- No security requirements

**Prevention**:

- Threat model during design
- Security requirements from start
- Defense in depth
- Secure by default

### 5. Security Misconfiguration

**Issue**: Insecure default settings

**Examples**:

- Default credentials
- Unnecessary features enabled
- Verbose error messages
- Missing security headers
- Outdated software

**Prevention**:

```python
# ✅ Good: Security headers
@app.after_request
def add_security_headers(response):
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-Frame-Options'] = 'DENY'
    response.headers['X-XSS-Protection'] = '1; mode=block'
    response.headers['Strict-Transport-Security'] = 'max-age=31536000'
    return response

# ✅ Good: Non-verbose errors in production
app.config['DEBUG'] = False  # Never debug in production
```

### 6. Vulnerable and Outdated Components

**Issue**: Using libraries with known vulnerabilities

**Examples**:

- Unmaintained dependencies
- Known CVEs in libraries
- No dependency scanning

**Prevention**:

```bash
# Check for vulnerabilities
npm audit
pip-audit
snyk test

# Auto-update dependencies
# Use Dependabot, Renovate
```

### 7. Identification and Authentication Failures

**Issue**: Weak authentication mechanisms

**Examples**:

- Weak password requirements
- No MFA (Multi-Factor Authentication)
- Session fixation
- Credential stuffing

**Prevention**:

```python
# ✅ Password requirements
MIN_PASSWORD_LENGTH = 12
REQUIRE_COMPLEXITY = True

# ✅ Rate limiting
@limiter.limit("5 per 15 minutes")
@app.route('/login', methods=['POST'])
def login():
    ...

# ✅ Secure session
app.config['SESSION_COOKIE_SECURE'] = True  # HTTPS only
app.config['SESSION_COOKIE_HTTPONLY'] = True  # No JS access
app.config['SESSION_COOKIE_SAMESITE'] = 'Lax'  # CSRF protection
```

### 8. Software and Data Integrity Failures

**Issue**: Code/data modified without verification

**Examples**:

- Auto-update without signature verification
- Insecure deserialization
- CI/CD without integrity checks

**Prevention**:

```python
# ❌ Bad: Unsafe deserialization
import pickle
data = pickle.loads(user_input)  # Code execution risk!

# ✅ Good: Safe deserialization
import json
data = json.loads(user_input)  # Data only, no code
```

### 9. Security Logging and Monitoring Failures

**Issue**: Insufficient logging of security events

**Examples**:

- Login failures not logged
- No alerting on suspicious activity
- Logs not monitored

**Prevention**:

```python
# ✅ Log security events
import logging
security_logger = logging.getLogger('security')

@app.route('/login', methods=['POST'])
def login():
    if not authenticate(username, password):
        security_logger.warning(
            f"Failed login attempt: {username} from {request.remote_addr}"
        )
        return "Invalid credentials", 401
```

### 10. Server-Side Request Forgery (SSRF)

**Issue**: Application fetches remote resource without validation

**Examples**:

- URL parameter not validated
- Internal network access
- Cloud metadata access

**Prevention**:

```python
# ❌ Bad: Unvalidated URL
url = request.args.get('url')
response = requests.get(url)  # Can access internal network!

# ✅ Good: Whitelist domains
ALLOWED_DOMAINS = ['api.example.com', 'cdn.example.com']

def is_safe_url(url):
    parsed = urlparse(url)
    return parsed.netloc in ALLOWED_DOMAINS

if is_safe_url(url):
    response = requests.get(url)
```

## Common Vulnerability Checks

### Secret Detection

**Check For**:

- API keys in code
- Database credentials
- Private keys
- OAuth tokens

**Tools**:

```bash
# detect-secrets
detect-secrets scan

# git-secrets
git secrets --scan

# GitHub secret scanning (automatic)
```

### Input Validation

**Always Validate**:

- Type (string, int, email, etc.)
- Length (min, max)
- Format (regex)
- Range (min, max for numbers)
- Whitelist (allowed values)

**Example**:

```python
from email_validator import validate_email

def register_user(email, age, role):
    # Validate email
    validate_email(email)

    # Validate age
    if not isinstance(age, int) or not (18 <= age <= 150):
        raise ValueError("Invalid age")

    # Validate role (whitelist)
    if role not in ['user', 'moderator']:  # Never 'admin'
        raise ValueError("Invalid role")
```

### CSRF Protection

**Issue**: Attacker tricks user into unwanted action

**Prevention**:

```python
# Use CSRF tokens
from flask_wtf.csrf import CSRFProtect
csrf = CSRFProtect(app)

# Or same-site cookies
app.config['SESSION_COOKIE_SAMESITE'] = 'Strict'
```

## Security Testing

**Static Analysis (SAST)**:

- Bandit (Python)
- ESLint security plugins (JavaScript)
- Semgrep (multi-language)
- SonarQube

**Dependency Scanning**:

- npm audit
- pip-audit
- Snyk
- Dependabot

**Dynamic Analysis (DAST)**:

- OWASP ZAP
- Burp Suite
- Manual penetration testing

## Security Checklist

**Authentication**:

- [ ] Strong password requirements (min 12 chars)
- [ ] Passwords hashed with bcrypt/argon2
- [ ] Rate limiting on login (5 attempts / 15 min)
- [ ] Session tokens cryptographically random
- [ ] HTTPS-only, HttpOnly, SameSite cookies
- [ ] MFA available for sensitive accounts

**Authorization**:

- [ ] Check permissions on every request
- [ ] Principle of least privilege
- [ ] No elevation without verification
- [ ] Admin features require admin role

**Data Protection**:

- [ ] HTTPS everywhere (no HTTP)
- [ ] Sensitive data encrypted at rest
- [ ] No secrets in code
- [ ] PII handling compliant (GDPR, etc.)

**Input Validation**:

- [ ] All user input validated
- [ ] SQL queries parameterized
- [ ] Output escaped (XSS prevention)
- [ ] File upload restrictions (type, size)

**Security Headers**:

- [ ] Content-Security-Policy
- [ ] X-Content-Type-Options: nosniff
- [ ] X-Frame-Options: DENY
- [ ] Strict-Transport-Security

**Logging**:

- [ ] Security events logged
- [ ] Sensitive data not logged (passwords, tokens)
- [ ] Logs monitored and alerted
- [ ] Log retention policy

## Integration with Other Skills

**First-Principles Thinking**:

- Question: "What could an attacker do with this?"
- Think like an attacker
- Verify security from fundamentals

**Tech Stack Advisor**:

- Use framework security features
- Keep dependencies updated
- Choose secure defaults

**Reviewer Mode**:

- Security review on every PR
- Critical security issues block merge
- Second pair of eyes for security

## Best Practices

**Do**:
✅ Validate all user input
✅ Use parameterized queries
✅ Hash passwords with bcrypt/argon2
✅ Implement rate limiting
✅ Log security events
✅ Keep dependencies updated
✅ Use HTTPS everywhere
✅ Apply principle of least privilege

**Don't**:
❌ Trust user input
❌ Roll your own crypto
❌ Store passwords in plain text
❌ Use MD5/SHA1 for passwords
❌ Expose sensitive data in errors
❌ Ignore dependency vulnerabilities
❌ Give everyone admin access

## See Also

- [REVIEWER.md](REVIEWER.md) - Security code review
- [GUARDIAN.md](GUARDIAN.md) - Automated security scanning
- [AUDITOR.md](AUDITOR.md) - Security audits
- [REFERENCES.md](REFERENCES.md) - Complete navigation
