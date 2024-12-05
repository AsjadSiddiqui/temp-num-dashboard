import cors from 'cors';
import dotenv from 'dotenv';
import express, { Application } from 'express';
import phoneRoutes from './routes/phone';

dotenv.config();

const app: Application = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use('/api', phoneRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});