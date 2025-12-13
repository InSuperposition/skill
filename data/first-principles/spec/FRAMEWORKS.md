# Questioning Frameworks - Systematic First Principles Thinking

## Overview

Questioning frameworks provide systematic approaches to challenge assumptions, examine ideas, and reason from fundamentals. This guide highlights five complementary tools—Socratic Method, Five Whys, Cartesian Doubt, Feynman Technique, and Simple Made Easy—and explains when to reach for each. Use this document as the comparison hub, then open the detailed templates in `frameworks/` for facilitation scripts, examples, and exercises.

## Framework Selection Guide

### Quick Reference

| Framework | Best For | Typical Duration | Depth Level |
|-----------|----------|------------------|-------------|
| **Socratic Method** | Examining ideas, clarifying thinking | 20-40 min | Deep |
| **Five Whys** | Finding root causes quickly | 5-15 min | Focused |
| **Cartesian Doubt** | Validating assumptions rigorously | 30-60 min | Very Deep |
| **Feynman Technique** | Testing understanding, explaining | 15-30 min | Moderate |
| **Simple Made Easy** | Evaluating solution simplicity vs ease | 20-30 min | Meta/Structural |

### Selection Criteria

**Use Socratic Method when** you need precise language, shared definitions, or to surface hidden assumptions before exploring solutions.

**Use Five Whys when** a concrete symptom is visible and you need to move quickly from effect to root cause without over-investing.

**Use Cartesian Doubt when** a decision rests on stacked assumptions and you must reduce the problem to indubitable truths.

**Use Feynman Technique when** you want to verify understanding, produce clear documentation, or identify knowledge gaps.

**Use Simple Made Easy when** an option "feels" easy, but you suspect hidden coupling or accidental complexity; it is the structural sanity check before committing.

## Framework Snapshots

### Socratic Method

- **Primary job**: Clarify thinking and expose hidden assumptions through layered questioning.
- **Key prompts**: "What do you mean by…?", "What evidence supports…?", "What follows if…?", "What question should we ask instead?"
- **Best moment**: Early exploration when stakeholders disagree on definitions or when a claim feels fuzzy.
- **Pair with**: Five Whys to tighten each "why" statement; Simple Made Easy to verify conclusions remain orthogonal.
- **Full playbook**: [frameworks/socratic-method.md](../frameworks/socratic-method.md)

### Five Whys

- **Primary job**: Move from symptom to root cause via sequential "Why?" questions.
- **Key prompts**: "Why did this happen?", "What made that possible?", "What process allowed this?", "How can we verify this answer?"
- **Best moment**: Immediately after an incident or observable symptom when fast analysis matters.
- **Pair with**: Socratic questions for precision, then Simple Made Easy to ensure the fix isn't merely convenient.
- **Full playbook**: [frameworks/five-whys.md](../frameworks/five-whys.md)

### Cartesian Doubt

- **Primary job**: Strip away every assumption that can be doubted until only facts remain.
- **Key prompts**: "Can this be doubted?", "What observable evidence backs this?", "If we discard this belief, what survives?"
- **Best moment**: High-stakes calls or situations built on inherited assumptions and conventional wisdom.
- **Pair with**: Feynman Technique to restate the remaining truths simply before rebuilding reasoning.
- **Full playbook**: [frameworks/cartesian-doubt.md](../frameworks/cartesian-doubt.md)

### Feynman Technique

- **Primary job**: Test understanding by explaining a concept so clearly that a beginner can follow.
- **Key prompts**: "Explain this plainly", "Where did jargon sneak in?", "What analogy clarifies this?", "What gap surfaced?"
- **Best moment**: Documentation, knowledge transfer, interviews, or any time you suspect you're operating on memorized patterns.
- **Pair with**: Simple Made Easy so the "simple explanation" corresponds to an objectively simple structure.
- **Full playbook**: [frameworks/feynman-technique.md](../frameworks/feynman-technique.md)

### Simple Made Easy

- **Primary job**: Distinguish objective simplicity (unentangled, orthogonal pieces) from subjective ease (convenience, familiarity).
- **Key prompts**: "Is this singular?", "Where are responsibilities entangled?", "Are we making it simple first, then easy?", "What hidden couplings exist?"
- **Best moment**: Comparing architectures, planning refactors, or whenever "easy" arguments dominate the discussion.
- **Pair with**: Any other framework as a final sanity check before you commit to an option.
- **Full playbook**: [frameworks/simple-made-easy.md](../frameworks/simple-made-easy.md)

## Combining Frameworks

### Socratic Method + Five Whys

Use Socratic prompts to clarify each "why" statement before moving to the next. This prevents vague answers ("tests are flaky") from derailing root-cause analysis and keeps every layer tied to observable facts.

### Cartesian Doubt + Feynman Technique

After doubting every assumption, restate the surviving truths using the Feynman Technique. If you can't explain the remaining claims simply, they are not yet fundamental.

### Full Stack Flow

1. **Socratic Method** – Define the problem precisely and surface assumptions.
2. **Five Whys** – Drill to the root cause of the precise problem.
3. **Cartesian Doubt** – Validate that the identified cause truly holds.
4. **Feynman Technique** – Explain the chosen solution plainly to confirm understanding.
5. **Simple Made Easy** – Ensure the recommended fix keeps responsibilities orthogonal and composable before shipping.

## See Also

- [GUIDE.md](GUIDE.md) – When and how to use questioning frameworks
- [FACILITATOR.md](FACILITATOR.md) – Applying frameworks in interactive sessions
- [METHODOLOGY.md](METHODOLOGY.md) – Integrating frameworks into the overall FPT process
- [DECONSTRUCTION.md](DECONSTRUCTION.md) – Using frameworks for problem breakdown
- [RECONSTRUCTION.md](RECONSTRUCTION.md) – Using frameworks for solution building
- [EXAMPLES.md](EXAMPLES.md) – Real-world applications of the frameworks
- [REFERENCES.md](REFERENCES.md) – Complete documentation map
