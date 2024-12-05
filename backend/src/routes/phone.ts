import { Router } from 'express';
import { getPhoneInfo } from '../controllers/phoneController';
import { authenticate } from '../middleware/authMiddleware';

const router = Router();

router.get('/phone-info', authenticate, getPhoneInfo);

export default router;