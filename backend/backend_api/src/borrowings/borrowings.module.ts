import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { Borrowing } from './entities/borrowing.entity';
import { BorrowingsController } from './borrowings.controller';
import { BorrowingsService } from './borrowings.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([Borrowing]),
  ],
  controllers: [BorrowingsController],
  providers: [BorrowingsService],
})
export class BorrowingsModule {}    