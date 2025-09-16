+++
date = '2025-09-17T00:00:00-05:00'
draft = false
title = "Markov Chain Monte Carlo (MCMC)"
+++

**Metropolis-Hashtings Algorithm** is a Markov Chain Monte Carlo (MCMC) method for obtaining a sequence
of random samples which converge to being distributed according to a target probability distribution
for which direct sampling is difficult.

# Introduction

This article assumes the reader understands the following:
- Markov Chains & its properties:
  - ergodic property
  - stationary distribution
  - detailed balanced
- Monte Carlo Methods

## Problem:

- approximate or sample from target distribution 𝜋

## Solution:

- Markov Chain idea: given an ergodic transition matrix 𝑇 there exists a stationary distribution 𝜋
- Metropolis Algorithm idea: given a target distribution 𝜋 construct an ergodic transition matrix 𝑇 that will produce 𝜋
  - the ergodic theorem states that sampling from this Markov chain 𝑇 will approximate the target distribution 𝜋

## Metropolis Algorithm:

1. given current state 𝑥, sample next state 𝑥' from a proposal distribution 𝐐(𝑥 → 𝑥')
2. accept next state 𝑥' with acceptance probability 𝐀(𝑥 → 𝑥')
    - if accepted, move to 𝑥'
    - otherwise stay at 𝑥
3. repeat 𝑛 number of times

From the algorithm, the transition function 𝑇 is defined as:

if 𝑥 ≠ 𝑥':
- $𝑇(𝑥 → 𝑥') = 𝐐(𝑥 → 𝑥')𝐀(𝑥 → 𝑥')$

if 𝑥 = 𝑥':
- $𝑇(𝑥 → 𝑥) = 𝐐(𝑥 → 𝑥) + 𝛴_{𝑥≠𝑥'} [𝐐(𝑥 → 𝑥')(1 - 𝐀(𝑥 → 𝑥'))]$

construct acceptance probability 𝐀 such that detailed balance holds for 𝑇 
(detailed balance implies stationary distribution, and thus the ergodic theorem above applies):

1. $𝜋(𝑥')𝑇(𝑥' → 𝑥) = 𝜋(𝑥)𝑇(𝑥 → 𝑥')$
2. $𝜋(𝑥')𝐐(𝑥' → 𝑥)𝐀(𝑥' → 𝑥) = 𝜋(𝑥)𝐐(𝑥 → 𝑥')𝐀(𝑥 → 𝑥')$
3. $\frac{𝐀(𝑥 → 𝑥')}{𝐀(𝑥' → 𝑥)} = \frac{𝜋(𝑥')𝐐(𝑥' → 𝑥)}{𝜋(𝑥)𝐐(𝑥 → 𝑥')}$
4. $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋(𝑥')𝐐(𝑥' → 𝑥)}{𝜋(𝑥)𝐐(𝑥 → 𝑥')})$
5. $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{\frac{𝜋'(𝑥')}{𝑍} 𝐐(𝑥' → 𝑥)}{\frac{𝜋'(𝑥)}{𝑍} 𝐐(𝑥 → 𝑥')})$
6. $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋'(𝑥') 𝐐(𝑥' → 𝑥)}{𝜋'(𝑥) 𝐐(𝑥 → 𝑥')})$

1 by definition of detailed balanced

5 because 𝜋(𝑥) is assumed to be hard to compute because of its normalizing constant 1/𝑍, we can rewrite it as $𝜋(𝑥) = \frac{𝜋'(𝑥)}{𝑍}$

6 the normalizing constants are cancelled out, rendering 𝐀(𝑥 → 𝑥') to be easy to compute



# Choice of Proposal Distribution 𝐐

𝐐 must be reversible:
- 𝐐(𝑥' → 𝑥) > 0 implies 𝐐(𝑥 → 𝑥') > 0

opposing forces:
- 𝐐 should be spread out to improve mixing
- but then acceptance probability will be low, which in turn slows down mixing

## Random Walk Metropolis

If 𝐐 is chosen to be symmetric (i.e. 𝐐(𝑥 → 𝑥') = 𝐐(𝑥' → 𝑥) for all 𝑥' and 𝑥), then the acceptance probability 𝐀 becomes:
- $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋(𝑥')𝐐(𝑥'→ 𝑥)}{𝜋(𝑥)𝐐(𝑥 → 𝑥')})$
- $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋(𝑥')}{𝜋(𝑥)})$

now:

- if 𝑥' has density greater than or equal to 𝑥's density (i.e. 𝜋(𝑥') ≥ 𝜋(𝑥)) then we will always accept 𝑥'
- if 𝑥' has density less than 𝑥's density (i.e. 𝜋(𝑥') < 𝜋(𝑥)) then we will always accept 𝑥' with probability $\frac{𝜋(𝑥')}{𝜋(𝑥)}$

## Independent Metropolis-Hastings Proposal

If 𝐐 is chosen to be independent (i.e. 𝐐(𝑥 → 𝑥') = 𝐐(𝑥')), then the acceptance probability becomes:

- $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋(𝑥')𝐐(𝑥'→ 𝑥)}{𝜋(𝑥)𝐐(𝑥 → 𝑥')})$
- $𝐀(𝑥 → 𝑥') = 𝑚𝑖𝑛(1, \frac{𝜋(𝑥')𝐐(𝑥)}{𝜋(𝑥)𝐐(𝑥')})$

# Resources

- [YouTube - Very Normal](https://www.youtube.com/watch?v=Jr1GdNI3Vfo)
- [YouTube - mathematicalmonk](https://www.youtube.com/watch?v=gxHe9wAWuGQ)
- [YouTube - Jarad Niemi](https://www.youtube.com/watch?v=VGRVRjr0vyw)
- [YouTube - Kapil Sachdeva](https://www.youtube.com/watch?v=oX2wIGSn4jY)
- [Coursera - Probabilistic Graphical Models 2](https://www.coursera.org/lecture/probabilistic-graphical-models-2-inference/metropolis-hastings-algorithm-UPVWC)
