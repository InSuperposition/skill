# Performance - Optimization and Efficiency Analysis

## Overview

Performance analysis identifies bottlenecks, inefficiencies, and optimization opportunities. This guide covers algorithmic complexity, database optimization, caching strategies, and profiling techniques.

**Philosophy**: "Premature optimization is evil, but informed optimization is essential" - measure first, optimize what matters.

## Performance Dimensions

### 1. Algorithmic Complexity

**Big O Analysis**:

- O(1) - Constant: Ideal
- O(log n) - Logarithmic: Excellent (binary search)
- O(n) - Linear: Good
- O(n log n) - Log-linear: Acceptable (good sorting)
- O(n²) - Quadratic: Bad (nested loops)
- O(2ⁿ) - Exponential: Terrible

**Common Issues**:

**Nested Loops** (O(n²)):

```python
# ❌ Bad: O(n²)
for user in users:
    for order in orders:
        if order.user_id == user.id:
            process(order)

# ✅ Good: O(n)
orders_by_user = defaultdict(list)
for order in orders:
    orders_by_user[order.user_id].append(order)

for user in users:
    for order in orders_by_user[user.id]:
        process(order)
```

**Inefficient Search** (O(n) vs O(1)):

```python
# ❌ Bad: O(n) lookup
if item in item_list:  # List scan

# ✅ Good: O(1) lookup
if item in item_set:  # Hash lookup
```

### 2. Database Performance

**N+1 Query Problem**:

```python
# ❌ Bad: 1 + N queries
users = User.query.all()  # 1 query
for user in users:
    user.posts = Post.query.filter_by(user_id=user.id).all()  # N queries

# ✅ Good: 1 query with JOIN
users = User.query.options(joinedload(User.posts)).all()
```

**Missing Indexes**:

```sql
-- Slow: Full table scan
SELECT * FROM orders WHERE user_id = 123;

-- Add index
CREATE INDEX idx_orders_user ON orders(user_id);

-- Fast: Index scan
SELECT * FROM orders WHERE user_id = 123;
```

**SELECT * Abuse**:

```sql
-- ❌ Bad: Fetching unnecessary columns
SELECT * FROM users;  -- 50 columns, only need 2

-- ✅ Good: Select only needed columns
SELECT id, name FROM users;
```

### 3. Memory Optimization

**Memory Leaks**:

```python
# ❌ Bad: Growing global cache
_cache = {}  # Never cleaned, grows forever

# ✅ Good: LRU cache with size limit
from functools import lru_cache

@lru_cache(maxsize=1000)
def expensive_function(arg):
    ...
```

**Large Object Creation**:

```python
# ❌ Bad: Loading entire file into memory
data = open('huge_file.txt').read()  # 10GB file!

# ✅ Good: Stream processing
with open('huge_file.txt') as f:
    for line in f:  # One line at a time
        process(line)
```

### 4. Network & I/O

**Synchronous Blocking**:

```python
# ❌ Bad: Sequential API calls
result1 = fetch_api_1()  # Wait 500ms
result2 = fetch_api_2()  # Wait 500ms
result3 = fetch_api_3()  # Wait 500ms
# Total: 1500ms

# ✅ Good: Parallel with async
results = await asyncio.gather(
    fetch_api_1(),
    fetch_api_2(),
    fetch_api_3()
)
# Total: 500ms (concurrent)
```

**Chatty APIs**:

```python
# ❌ Bad: Multiple round trips
for user_id in user_ids:
    user = api.get_user(user_id)  # N API calls

# ✅ Good: Batch request
users = api.get_users_batch(user_ids)  # 1 API call
```

## Performance Profiling

**Python Profiling**:

```python
import cProfile
import pstats

# Profile function
profiler = cProfile.Profile()
profiler.enable()
slow_function()
profiler.disable()

# View results
stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(10)  # Top 10 functions
```

**JavaScript Profiling**:

```javascript
// Browser: Chrome DevTools Performance tab
// Node.js: --prof flag
node --prof app.js
node --prof-process isolate-*.log
```

**Database Profiling**:

```sql
-- PostgreSQL: EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT * FROM orders WHERE user_id = 123;

-- MySQL: EXPLAIN
EXPLAIN SELECT * FROM orders WHERE user_id = 123;
```

## Caching Strategies

**Application Caching**:

```python
# Redis cache
from redis import Redis
cache = Redis()

def get_user(user_id):
    # Check cache
    cached = cache.get(f"user:{user_id}")
    if cached:
        return json.loads(cached)

    # Fetch from DB
    user = User.query.get(user_id)

    # Store in cache (1 hour)
    cache.setex(f"user:{user_id}", 3600, json.dumps(user))

    return user
```

**HTTP Caching**:

```python
# Set cache headers
@app.route('/static/image.jpg')
def serve_image():
    response = send_file('image.jpg')
    response.headers['Cache-Control'] = 'public, max-age=31536000'
    return response
```

## Optimization Checklist

**Database**:

- [ ] Indexes on query predicates
- [ ] No N+1 queries
- [ ] Connection pooling
- [ ] Query result caching
- [ ] SELECT only needed columns

**Algorithms**:

- [ ] No nested loops on large datasets
- [ ] Use appropriate data structures (set vs list)
- [ ] Binary search instead of linear
- [ ] Memoization for expensive calculations

**Network**:

- [ ] Batch API requests
- [ ] Async for I/O operations
- [ ] CDN for static assets
- [ ] Compression (gzip)
- [ ] HTTP/2 or HTTP/3

**Memory**:

- [ ] Stream large files
- [ ] LRU cache with limits
- [ ] Release resources (close connections)
- [ ] No memory leaks

## Best Practices

**Measure First**:

1. Profile to find bottlenecks
2. Set performance targets
3. Optimize hot paths only
4. Measure improvement

**Low-Hanging Fruit**:

- Add database indexes
- Fix N+1 queries
- Add caching layer
- Use CDN for static files
- Enable compression

**Don't**:
❌ Optimize without profiling
❌ Prematurely optimize
❌ Sacrifice readability for micro-optimization
❌ Ignore algorithmic complexity

## See Also

- [REVIEWER.md](REVIEWER.md) - Performance review in PRs
- [AUDITOR.md](AUDITOR.md) - Performance audits
- [REFERENCES.md](REFERENCES.md) - Navigation
