import { NextFunction, Request, Response } from 'express';

// const AUTH_TOKEN =  || '';

export const authenticate = (req: Request, res: Response, next: NextFunction): void => {
  const authHeader = req.headers['authorization'];

  if (!authHeader) {
    res.status(401).json({ message: 'No token provided' });
    return;
  }

  // "Bearer <token>"
  const token = authHeader.split(' ')[1];

  const AUTH_TOKEN = process.env.AUTH_TOKEN || '';

  if (token === AUTH_TOKEN) {
    next();
  } else {
    res.status(403).json({ message: 'Invalid token', providedToken: token, expectedToken: AUTH_TOKEN });
  }
};