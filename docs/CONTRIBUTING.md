# Contributing to OSS Architecture Reports

Thank you for your interest in contributing! This document explains how you can help improve this project.

## How to Request a New Report

If you would like a report for an OSS project that is not yet covered:

1. Go to the [Issues](../../issues) page
2. Click "New Issue"
3. Select the "OSS Report Request" template if available, or create a blank issue
4. Use the project name as the title, prefixed with "Request:" (e.g., `Request: Caddy`)
5. No description is required, but you may add context if you wish

The report will be generated and published shortly after the request is reviewed.

## How to Improve Existing Reports

If you find inaccuracies or want to enhance an existing report:

1. Fork the repository
2. Create a branch from `main` (e.g., `fix/project-name-correction`)
3. Make your changes in the relevant `oss/{project-name}/README.md` file
4. Submit a Pull Request with a clear description of what was changed and why

### What makes a good improvement

- Correcting factual errors about a project's architecture
- Updating outdated information (e.g., major version changes)
- Adding missing sections or clarifying existing explanations
- Fixing broken links or diagram errors

## Writing Guidelines

All reports and contributions must follow these rules:

### Formatting

- Do not use asterisk-based bold syntax in markdown files
- Use headings, subheadings, and list structures for emphasis instead
- Write in English
- Follow the existing report template structure (see README.md for the full section list)

### Report Structure

Each report must include the following sections in order:

1. Metadata
2. Overview
3. Architecture Overview (with Mermaid diagrams)
4. Core Components
5. Data Flow (with sequence diagrams)
6. Key Design Decisions
7. Dependencies
8. Testing Strategy
9. Key Takeaways
10. References

### Mermaid Diagrams

- Use Mermaid syntax for all diagrams
- Keep diagrams readable and not overly complex
- Include both high-level architecture diagrams and sequence diagrams

## Code of Conduct

This project follows a simple code of conduct:

- Be respectful and constructive in all interactions
- Welcome newcomers and help them contribute
- Focus on facts and technical merit when discussing changes
- Assume good intentions from other contributors
- Keep discussions on-topic and professional

Harassment, discrimination, or disrespectful behavior of any kind will not be tolerated.

## Questions

If you have any questions about contributing, feel free to open an Issue with the "Question" label.
