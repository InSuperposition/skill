# Dieter Rams: Ten Principles of Good Design

## What It Is

Dieter Rams' Ten Principles of Good Design represent over 50 years of design philosophy from one of the most influential industrial designers of the 20th century. Working at Braun and Vitsœ, Rams developed these principles (sometimes called the "Ten Commandments") to guide the creation of products that are functional, understandable, and long-lasting.

The principles embody Rams' design motto: **"Weniger, aber besser"** - "Less, but better."

## The Philosophy: Less, but Better

Rams' approach isn't about minimalism for aesthetics alone. It's about simplicity as a result of removing unnecessary additions. The goal is to concentrate on essential aspects without burdening products with non-essentials. Back to purity, back to simplicity.

**Making designs good means making them simple; making great designs means staying focused only on the essentials.**

## The Ten Principles

### 1. Good Design is Innovative

The possibilities for innovation are not, by any means, exhausted. Technological development is always offering new opportunities for innovative design. But innovative design always develops in tandem with innovative technology, and can never be an end in itself.

### 2. Good Design Makes a Product Useful

A product is bought to be used. It has to satisfy certain criteria, not only functional, but also psychological and aesthetic. Good design emphasizes the usefulness of a product whilst disregarding anything that could possibly detract from it.

### 3. Good Design is Aesthetic

The aesthetic quality of a product is integral to its usefulness because products we use every day affect our person and our well-being. But only well-executed objects can be beautiful.

### 4. Good Design Makes a Product Understandable

It clarifies the product's structure. Better still, it can make the product talk. At best, it is self-explanatory.

**Simplicity connection**: Understandability directly correlates with simplicity. Complex, entangled designs cannot be made understandable without dishonesty.

### 5. Good Design is Unobtrusive

Products fulfilling a purpose are like tools. They are neither decorative objects nor works of art. Their design should therefore be both neutral and restrained, to leave room for the user's self-expression.

**Simplicity connection**: Unobtrusive design stays out of the way by remaining simple and focused on purpose.

### 6. Good Design is Honest

It does not make a product more innovative, powerful or valuable than it really is. It does not attempt to manipulate the consumer with promises that cannot be kept.

### 7. Good Design is Long-Lasting

It avoids being fashionable and therefore never appears antiquated. Unlike fashionable design, it lasts many years—even in today's throwaway society.

**Simplicity connection**: Simple designs age better than complex ones. Fashion is complexity; timelessness is simplicity.

### 8. Good Design is Thorough Down to the Last Detail

Nothing must be arbitrary or left to chance. Care and accuracy in the design process show respect towards the user.

### 9. Good Design is Environmentally Friendly

Design makes an important contribution to the preservation of the environment. It conserves resources and minimizes physical and visual pollution throughout the lifecycle of the product.

### 10. Good Design is as Little Design as Possible

**This is the core simplicity principle.**

Less, but better—because it concentrates on the essential aspects, and the products are not burdened with non-essentials.

Back to purity, back to simplicity.

## Applying the Principles

### In Product Design

When designing physical or digital products:

1. **Question every element**: Does this serve the essential purpose?
2. **Remove decoration**: Strip away anything that isn't functional
3. **Seek clarity**: Can a user understand the product without instruction?
4. **Stay neutral**: Let the product's purpose speak, not the design
5. **Build to last**: Design for longevity, not trends

### In Software and Systems

Rams' principles translate powerfully to software:

- **Innovative**: Solve real problems in new ways, not innovation theater
- **Useful**: Every feature should serve a clear user need
- **Aesthetic**: Beauty emerges from clarity and organization
- **Understandable**: Code should explain its purpose; systems should be comprehensible
- **Unobtrusive**: Infrastructure should enable, not constrain
- **Honest**: No fake complexity or unnecessary abstraction
- **Long-lasting**: Choose boring technology that won't age poorly
- **Thorough**: No shortcuts, no "we'll fix it later"
- **Environmentally friendly**: Minimize resource consumption and waste
- **As little as possible**: Delete code, remove features, subtract complexity

### In Architecture and API Design

When designing systems and interfaces:

- **Start by subtracting**: What can we remove?
- **Seek orthogonality**: Each component should have one clear purpose
- **Make it self-explanatory**: Good design documents itself
- **Avoid fashion**: Don't adopt patterns because they're trendy
- **Sweat the details**: Rough edges compound into complexity

## Examples

### Example 1: Feature Bloat vs Essential Function

**Bloated Approach**: A text editor with 47 toolbar buttons, custom themes, animations, social features, cloud sync, AI suggestions, and a plugin marketplace.

**Rams Approach**: A text editor that:

- Displays text clearly (aesthetic, useful)
- Responds instantly (useful, honest)
- Saves reliably (thorough, environmentally friendly)
- Uses standard file formats (long-lasting)
- Has minimal UI chrome (unobtrusive, as little as possible)

The bloated version confuses ease (more features = more power?) with value. The simple version concentrates on essential aspects.

### Example 2: API Design

**Complex API**:

```javascript
api.resource.manager.factory.create({
  type: 'user',
  config: {
    validation: { enabled: true },
    hooks: { pre: [], post: [] }
  }
}).build().execute()
```

**Simple API** (Rams-inspired):

```javascript
api.createUser({ email, name })
```

The complex version adds layers that feel sophisticated but obscure the essential operation. The simple version is understandable, unobtrusive, and as little design as possible.

## The Rams Test

When evaluating a design, ask:

1. Does this **need** to exist? (Innovation, usefulness)
2. Can someone understand it immediately? (Understandable)
3. Does it stay out of the way? (Unobtrusive)
4. Will this still work in 5 years? (Long-lasting)
5. **What can I remove?** (As little as possible)

If you can't confidently answer yes to questions 1-4, or if question 5 reveals removable elements, the design isn't simple enough.

## Influence and Legacy

Rams' principles have profoundly influenced modern design, particularly:

- **Apple**: Jony Ive explicitly cited Rams as a major influence on Apple's design philosophy
- **Digital design**: UI/UX practitioners treat the principles as foundational
- **Industrial design**: Rams' work at Braun set standards for generations

The principles remain relevant because they're timeless—they focus on essential qualities that transcend technology and trends.

## Common Misunderstandings

### "Less, but better" ≠ "fewer features"

Rams isn't advocating for stripped-down products. He's advocating for products where every feature is essential and thoroughly considered.

### Minimalism ≠ Simplicity

Visual minimalism (white space, clean lines) can hide complexity. Rams cares about functional simplicity: does it work well and make sense?

### Aesthetic ≠ Decoration

Rams values aesthetics but defines them as emerging from function and clarity, not applied styling.

## Takeaways

- **Simplicity through subtraction**: Remove non-essentials to reveal essence
- **Purpose over decoration**: Form follows function, always
- **Timeless over trendy**: Simple designs don't age
- **Honesty**: Don't fake complexity or capability
- **The tenth principle is the key**: Good design is as little design as possible

Dieter Rams' principles provide a practical, time-tested framework for achieving simplicity through thoughtful reduction and focus on essentials.

## References

- [What is "Good" Design? A quick look at Dieter Rams' Ten Principles - Design Museum](https://designmuseum.org/discover-design/all-stories/what-is-good-design-a-quick-look-at-dieter-rams-ten-principles)
- [Dieter Rams: 10 Timeless Commandments for Good Design - Interaction Design Foundation](https://www.interaction-design.org/literature/article/dieter-rams-10-timeless-commandments-for-good-design)
- [Good design - Vitsœ](https://www.vitsoe.com/us/about/good-design)
